part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class SaveProfileEvent extends EditProfileEvent {
  final User user;
  final File profileImageFile;

  SaveProfileEvent({
    @required this.user,
    this.profileImageFile,
  });

  @override
  List<Object> get props => [user, profileImageFile];
}
