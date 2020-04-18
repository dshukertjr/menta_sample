import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository = PostRepository();

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
    postRepository.likePost(postId);
  }

  Stream<PostState> _mapUnlikedPostEventToState(String postId) async* {
    postRepository.unlikePost(postId);
  }
}
