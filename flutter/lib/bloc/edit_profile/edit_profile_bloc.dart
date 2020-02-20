import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/models/user.dart';
import 'package:sample/repositories/user_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository userRepository;

  EditProfileBloc({@required this.userRepository});

  @override
  EditProfileState get initialState => EditProfileInitial();

  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    if (event is ChangeProfileImageEvent) {
      yield* _mapChangeProfileImageEventToState(event.profileImageFile);
    } else if (event is SaveProfileEvent) {
      yield* _mapSaveProfileEventToState(event.user);
    }
  }

  Stream<EditProfileState> _mapChangeProfileImageEventToState(
      File file) async* {}

  Stream<EditProfileState> _mapSaveProfileEventToState(User user) async* {
    yield SavingProfileState();
    userRepository.saveUserProfile(user);
    yield EditProfileInitial();
  }
}
