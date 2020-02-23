part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class DeletePostEvent extends PostEvent {
  final String postId;

  DeletePostEvent(this.postId);

  @override
  List<Object> get props => [postId];
}

class LikedPostEvent extends PostEvent {
  final String postId;

  LikedPostEvent(this.postId);

  @override
  List<Object> get props => [postId];
}

class UnlikedPostEvent extends PostEvent {
  final String postId;

  UnlikedPostEvent(this.postId);

  @override
  List<Object> get props => [postId];
}
