import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final PostRepository postRepository;

  ProfileBloc({
    @required this.userRepository,
    @required this.postRepository,
  });

  @override
  ProfileState get initialState => ProfileInitial();

  StreamSubscription<User> _userListener;
  StreamSubscription<List<Post>> _userPostsListener;
  User _user;
  bool _isTheirOwnProfile;
  List<Post> _userPosts = [];

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfileEvent) {
      yield* _mapLoadProfileEventToState(event.uid);
    } else if (event is UpdateProfileEvent) {
      yield* _mapUpdateProfileEventToState();
    }
  }

  Stream<ProfileState> _mapLoadProfileEventToState([String uid]) async* {
    if (uid == null) {
      // if uid is null, the user is getting their own profile
      _isTheirOwnProfile = true;
      userRepository.onAuthStateChanged().listen((firebaseUser) {
        _userListener?.cancel();
        if (firebaseUser?.uid != null) {
          _userListener =
              userRepository.userStream(firebaseUser.uid).listen((user) {
            _user = user;
            add(UpdateProfileEvent());
          });
          _userPostsListener?.cancel();
          _userPostsListener =
              postRepository.userPostsStream(firebaseUser.uid).listen((posts) {
            _userPosts = posts;
            add(UpdateProfileEvent());
          });
        }
      });
    } else {
      _isTheirOwnProfile = false;
      userRepository.userStream(uid).listen((user) {
        _user = user;
        add(UpdateProfileEvent());
        _userPostsListener?.cancel();
        _userPostsListener =
            postRepository.userPostsStream(_user.uid).listen((posts) {
          _userPosts = posts;
          add(UpdateProfileEvent());
        });
      });
    }
  }

  Stream<ProfileState> _mapUpdateProfileEventToState() async* {
    yield LoadedProfileState(
      user: _user,
      isTheirOwnProfile: _isTheirOwnProfile,
      posts: _userPosts,
    );
  }

  @override
  Future<void> close() {
    _userListener?.cancel();
    _userPostsListener?.cancel();
    return super.close();
  }
}
