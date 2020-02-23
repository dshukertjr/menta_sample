part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingMoreState extends HomeState {
  final List<Post> posts;
  final User user;

  LoadingMoreState({
    this.posts,
    this.user,
  });

  @override
  List<Object> get props => [
        posts,
        user,
      ];
}

class LoadedHomeState extends HomeState {
  final List<Post> posts;
  final User user;

  LoadedHomeState({
    @required this.posts,
    @required this.user,
  });

  @override
  List<Object> get props => [
        posts,
        user,
      ];
}
