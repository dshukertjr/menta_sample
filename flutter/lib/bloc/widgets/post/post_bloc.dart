import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  PostBloc({
    @required this.postRepository,
    @required this.userRepository,
  });

  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is DeletePostEvent) {
      yield* _mapDeletePostEventToState(event.postId);
    } else if (event is LikedPostEvent) {
      yield* _mapLikedPostEventToState(event.postId);
    } else if (event is UnlikedPostEvent) {
      yield* _mapUnlikedPostEventToState(event.postId);
    }
  }

  Stream<PostState> _mapDeletePostEventToState(String postId) async* {
    postRepository.deletePost(postId);
  }

  Stream<PostState> _mapLikedPostEventToState(String postId) async* {
    final uid = await userRepository.getUid();
    postRepository.likePost(
      postId: postId,
      uid: uid,
    );
  }

  Stream<PostState> _mapUnlikedPostEventToState(String postId) async* {
    final uid = await userRepository.getUid();
    postRepository.unlikePost(
      postId: postId,
      uid: uid,
    );
  }
}
