part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class LoadedProfileState extends EditProfileState {
  final User user;

  LoadedProfileState({this.user});

  @override
  List<Object> get props => [user];
}

class SavingProfileState extends EditProfileState {}
