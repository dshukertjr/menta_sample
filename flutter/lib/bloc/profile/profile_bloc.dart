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

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfileEvent) {
      yield* _mapLoadProfileEventToState(event.uid);
    } else if (event is UpdateProfileEvent) {
      yield* _mapUpdateProfileEventToState(event.user);
    }
  }

  Stream<ProfileState> _mapLoadProfileEventToState([String uid]) async* {
    if (uid == null) {
      userRepository.onAuthStateChanged().listen((firebaseUser) {
        _userListener?.cancel();
        if (firebaseUser?.uid != null) {
          _userListener = userRepository
              .userStream(firebaseUser.uid)
              .listen((user) => add(UpdateProfileEvent(user)));
        }
      });
    } else {
      userRepository
          .userStream(uid)
          .listen((user) => add(UpdateProfileEvent(user)));
    }
  }

  Stream<ProfileState> _mapUpdateProfileEventToState(User user) async* {
    yield LoadedProfileState(user: user);
  }
}
