import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';
import 'package:sample/repositories/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({@required this.userRepository});

  @override
  ProfileState get initialState => ProfileInitial();

  StreamSubscription<User> _userListener;
  User _user;
  bool _isTheirOwnProfile;

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
        }
      });
    } else {
      _isTheirOwnProfile = false;
      userRepository.userStream(uid).listen((user) {
        _user = user;
        add(UpdateProfileEvent());
      });
    }
  }

  Stream<ProfileState> _mapUpdateProfileEventToState() async* {
    yield LoadedProfileState(
      user: _user,
      isTheirOwnProfile: _isTheirOwnProfile,
    );
  }
}
