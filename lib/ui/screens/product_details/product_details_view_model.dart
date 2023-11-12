import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsViewModel extends Cubit {
  ProductDetailsViewModel() : super(ProductDetailsInitialState());
  int currentImageIndex = 0;

  setImageIndex(int newIndex) {
    currentImageIndex = newIndex;
    emit(ProductDetailsInitialState());
  }
}

class ProductDetailsInitialState {}
