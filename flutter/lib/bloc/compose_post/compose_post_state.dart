part of 'compose_post_bloc.dart';

abstract class ComposePostState extends Equatable {
  const ComposePostState();

  @override
  List<Object> get props => [];
}

class ComposePostInitial extends ComposePostState {}

class SubmittingPostState extends ComposePostState {}
