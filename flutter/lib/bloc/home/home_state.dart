part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<Post> posts;
  final User user;
  final bool loadingMorePosts;

  LoadedHomeState({
    @required this.posts,
    @required this.user,
    @required this.loadingMorePosts,
  });

  @override
  List<Object> get props => [posts, user, loadingMorePosts];
}
