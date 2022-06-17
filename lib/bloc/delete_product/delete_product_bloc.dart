import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  DeleteProductBloc() : super(DeleteProductInitial()) {
    on<DeleteProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
