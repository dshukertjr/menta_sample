import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  List<Post> _posts;
  User _user;
  StreamSubscription<List<Post>> _postsListener;
  StreamSubscription<FirebaseUser> _onAuthStateChangedListener;
  StreamSubscription<User> _userListener;

  HomeBloc({
    @required this.postRepository,
    @required this.userRepository,
  });

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is SetupHomeEvent) {
      yield* _mapSetupHomeEventToState();
    } else if (event is LoadMorePostsEvent) {
      yield* _mapLoadMorePostsEventToState();
    } else if (event is UpdateHomeEvent) {
      yield* _mapUpdateHomeEventToState();
    }
  }

  Stream<HomeState> _mapSetupHomeEventToState() async* {
    _postsListener?.cancel();
    _postsListener = postRepository.postsStream().listen((posts) {
      _posts = posts;
      add(UpdateHomeEvent(
        posts: _posts,
      ));
    });

    _onAuthStateChangedListener?.cancel();
    _onAuthStateChangedListener =
        userRepository.onAuthStateChanged().listen((firebaseUser) {
      _userListener?.cancel();
      if (firebaseUser != null) {
        _userListener =
            userRepository.userStream(firebaseUser.uid).listen((user) {
          _user = user;
          if (_posts != null) {
            add(UpdateHomeEvent(
              user: _user,
            ));
          }
        });
      }
    });
  }

  Stream<HomeState> _mapLoadMorePostsEventToState() async* {
    yield LoadingMoreState(posts: _posts, user: _user);
    _postsListener?.cancel();
    _postsListener = postRepository.postsStream().listen((posts) {
      _posts = posts;

      add(UpdateHomeEvent(
        posts: _posts,
        user: _user,
      ));
    });
  }

  Stream<HomeState> _mapUpdateHomeEventToState() async* {
    if (_posts != null && _user != null) {
      yield LoadedHomeState(
        posts: _posts,
        user: _user,
      );
    }
  }

  @override
  Future<void> close() {
    _postsListener?.cancel();
    _userListener?.cancel();
    _onAuthStateChangedListener?.cancel();
    return super.close();
  }
}
