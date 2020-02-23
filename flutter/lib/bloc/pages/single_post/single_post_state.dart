part of 'single_post_bloc.dart';

abstract class SinglePostState extends Equatable {
  const SinglePostState();
  @override
  List<Object> get props => [];
}

class SinglePostInitial extends SinglePostState {}

class LoadedPostState extends SinglePostState {
  final Post post;

  LoadedPostState(this.post);

  @override
  List<Object> get props => [post];
}
