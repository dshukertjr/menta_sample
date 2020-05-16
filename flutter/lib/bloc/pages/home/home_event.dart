part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SetupHomeEvent extends HomeEvent {}

class LoadMorePostsEvent extends HomeEvent {}

class UpdateHomeEvent extends HomeEvent {
  final List<Post> posts;
  final User user;

  UpdateHomeEvent({
    this.posts,
    this.user,
  });

  @override
  List<Object> get props => [
        posts,
        user,
      ];
}
