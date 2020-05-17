import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'compose_post_event.dart';
part 'compose_post_state.dart';

class ComposePostBloc extends Bloc<ComposePostEvent, ComposePostState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  ComposePostBloc({
    @required this.postRepository,
    @required this.userRepository,
  });

  @override
  ComposePostState get initialState => ComposePostInitial();

  @override
  Stream<ComposePostState> mapEventToState(
    ComposePostEvent event,
  ) async* {
    if (event is ComposeEvent) {
      yield* _mapComposeEventToState(
        text: event.text,
        imageFile: event.imageFile,
      );
    }
  }

  Stream<ComposePostState> _mapComposeEventToState(
      {@required String text, @required File imageFile}) async* {
    yield SubmittingPostState();
    final user = await userRepository.getUser();
    await postRepository.submitPost(
      text: text,
      imageFile: imageFile,
      user: user,
    );
    yield ComposePostInitial();
  }
}
