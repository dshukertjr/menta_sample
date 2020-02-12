part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SetupHomeEvent extends HomeEvent {}

class LoadMorePostsEvent extends HomeEvent {}

class UpdateHomeEvent extends HomeEvent {
  UpdateHomeEvent();
}
