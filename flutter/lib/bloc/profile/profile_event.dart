part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  // if uid is null, get the user's profile
  final String uid;

  LoadProfileEvent({@required this.uid});

  @override
  List<Object> get props => [uid];
}

class UpdateProfileEvent extends ProfileEvent {}
