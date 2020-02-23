part of 'single_post_bloc.dart';

abstract class SinglePostEvent extends Equatable {
  const SinglePostEvent();

  @override
  List<Object> get props => [];
}

class LoadPostEvent extends SinglePostEvent {
  final String postId;

  LoadPostEvent(this.postId);

  @override
  List<Object> get props => [postId];
}

class UpdateSinglePostEvent extends SinglePostEvent {
  final Post post;

  UpdateSinglePostEvent(this.post);

  @override
  List<Object> get props => [post];
}
