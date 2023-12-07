import 'package:crypto_test/models/pizza_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class pizzaBloc extends Bloc<PizzaEvent,PizzaState>{
  pizzaBloc(): super(PizzaInitial()){
    on<PizzaEvent>((event,emit){});}
}