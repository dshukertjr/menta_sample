part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class LoadedProfileState extends ProfileState {
  final User user;
  final bool isTheirOwnProfile;
  final List<Post> posts;

  LoadedProfileState({
    @required this.user,
    @required this.isTheirOwnProfile,
    @required this.posts,
  });

  @override
  List<Object> get props => [
        user,
        isTheirOwnProfile,
        posts,
      ];
}
