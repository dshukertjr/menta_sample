import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/post.dart';
import 'package:sample/models/user.dart';
import 'package:sample/pages/profile_page.dart';
import 'package:sample/repositories/post_repository.dart';
import 'package:sample/repositories/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  HomeBloc({
    @required this.postRepository,
    @required this.userRepository,
  });

  List<Post> _posts;
  User _user;
  bool _loadingMorePosts;
  StreamSubscription<List<Post>> _postsListener;
  StreamSubscription<FirebaseUser> _onAuthStateChangedListener;
  StreamSubscription<User> _userListener;

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
      add(UpdateHomeEvent());
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
            add(UpdateHomeEvent());
          }
        });
      }
    });
  }

  Stream<HomeState> _mapLoadMorePostsEventToState() async* {}

  Stream<HomeState> _mapUpdateHomeEventToState() async* {
    yield LoadedHomeState(
        posts: _posts, user: _user, loadingMorePosts: _loadingMorePosts);
  }
}
