import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';
import 'package:sample/repositories/post_repository.dart';

part 'compose_post_event.dart';
part 'compose_post_state.dart';

class ComposePostBloc extends Bloc<ComposePostEvent, ComposePostState> {
  final PostRepository postRepository;

  ComposePostBloc({
    this.postRepository,
  });

  @override
  ComposePostState get initialState => ComposePostInitial();

  @override
  Stream<ComposePostState> mapEventToState(
    ComposePostEvent event,
  ) async* {
    if (event is ComposeEvent) {
      yield* _mapComposeEventToState();
    }
  }

  Stream<ComposePostState> _mapComposeEventToState(
      {String text, File imageFile}) async* {
    yield SubmittingPostState();
  }
}
