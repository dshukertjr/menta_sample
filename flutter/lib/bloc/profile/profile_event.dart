part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final String uid;

  LoadProfileEvent({this.uid});

  @override
  List<Object> get props => [uid];
}

class UpdateProfileEvent extends ProfileEvent {
  final User user;

  UpdateProfileEvent(this.user);

  @override
  List<Object> get props => [user];
}
