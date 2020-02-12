part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends EditProfileEvent {}

class ChangeProfileImageEvent extends EditProfileEvent {
  final File profileImageFile;

  ChangeProfileImageEvent({this.profileImageFile});

  @override
  List<Object> get props => [profileImageFile];
}

class SaveProfileEvent extends EditProfileEvent {
  final User user;

  SaveProfileEvent({@required this.user});

  @override
  List<Object> get props => [user];
}
