import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:languages_project/data/web_services/like_web_services.dart';
import 'package:meta/meta.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeWebServices likeWebServices;
  LikeBloc({required this.likeWebServices}) : super(LikeInitial());
void like({required int id_product}){
  emit(LikeProcessing());
  LikeWebServices.GetData(url:'/like', id_product: id_product).then((value) {
    if(value.data.toString().contains('success')) {
      emit(LikeSuccess('success'));
    }
    emit(LikeSuccess(value.data));
  }).catchError((error){
    if(error.toString().contains('400')) {
      emit(LikeFailedState(errorMessage:'Liked already'));
    }
    emit(LikeFailedState(errorMessage:error.toString()));
  });
}
void unLike({required int id_product}){
  emit(unLikeProcessing());
  LikeWebServices.DeleteData(url:'/like', id_product: id_product).then((value) {
    if(value.data.toString().contains('success')) {
      emit(unLikeSuccess('success'));
    }
    emit(unLikeSuccess(value.data));
  }).catchError((error){
    if(error.toString().contains('400')) {
      emit(unLikeFailedState(errorMessage:'Liked already'));
    }
    emit(unLikeFailedState(errorMessage:error.toString()));
  });
}

}
