part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class LoadedProfileState extends ProfileState {
  final User user;

  LoadedProfileState({@required this.user});

  @override
  List<Object> get props => [user];
}
