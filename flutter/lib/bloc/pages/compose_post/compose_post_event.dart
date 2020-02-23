part of 'compose_post_bloc.dart';

abstract class ComposePostEvent extends Equatable {
  const ComposePostEvent();

  @override
  List<Object> get props => [];
}

class ComposeEvent extends ComposePostEvent {
  final String text;
  final File imageFile;

  ComposeEvent({
    @required this.text,
    @required this.imageFile,
  });
}
