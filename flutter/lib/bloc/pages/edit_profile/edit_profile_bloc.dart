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
    if (event is SaveProfileEvent) {
      yield* _mapSaveProfileEventToState(
        user: event.user,
        profileImageFile: event.profileImageFile,
      );
    }
  }

  Stream<EditProfileState> _mapSaveProfileEventToState(
      {User user, File profileImageFile}) async* {
    yield SavingProfileState();
    if (profileImageFile != null) {
      final profileImageUrl =
          await userRepository.uploadProfileImage(profileImageFile);
      user = user.copyWith(imageUrl: profileImageUrl);
    }
    userRepository.saveUserProfile(user);
    yield EditProfileInitial();
  }
}
