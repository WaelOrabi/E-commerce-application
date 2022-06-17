part of 'like_bloc.dart';

@immutable
abstract class LikeState {}
class LikeInitial extends LikeState {}

class LikeProcessing extends LikeState {}

class LikeSuccess extends LikeState {
  final String Like;

  LikeSuccess(this.Like);
}

class LikeFailedState extends LikeState {
  String errorMessage;
  LikeFailedState({required this.errorMessage});
}
class unLikeInitial extends LikeState {}

class unLikeProcessing extends LikeState {}

class unLikeSuccess extends LikeState {
  final String unLikeModel;

  unLikeSuccess(this.unLikeModel);
}

class unLikeFailedState extends LikeState {
  String errorMessage;
  unLikeFailedState({required this.errorMessage});
}

class ChangeLikeState extends LikeState {}


