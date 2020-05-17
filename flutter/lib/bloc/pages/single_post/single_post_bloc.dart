import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';

part 'single_post_event.dart';
part 'single_post_state.dart';

class SinglePostBloc extends Bloc<SinglePostEvent, SinglePostState> {
  final PostRepository postRepository;

  SinglePostBloc({@required this.postRepository});

  @override
  SinglePostState get initialState => SinglePostInitial();

  @override
  Stream<SinglePostState> mapEventToState(
    SinglePostEvent event,
  ) async* {
    if (event is LoadPostEvent) {
      yield* _mapLoadPostEventToState(event.postId);
    } else if (event is UpdateSinglePostEvent) {
      yield* _mapUpdateSinglePostEventToState(event.post);
    }
  }

  Stream<SinglePostState> _mapLoadPostEventToState(String postId) async* {
    postRepository.postStream(postId).listen((post) {
      add(UpdateSinglePostEvent(post));
    });
  }

  Stream<SinglePostState> _mapUpdateSinglePostEventToState(Post post) async* {
    yield LoadedPostState(post);
  }
}
