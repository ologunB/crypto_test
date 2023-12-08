import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

part 'watch_event.dart';
part 'watch_state.dart';

class WatchBloc extends Bloc<WatchEvent, List<String>> {
  static Box<dynamic> get _userBox => Hive.box<dynamic>('userBox');

  WatchBloc() : super(_userBox.get('watchlist', defaultValue: <String>[])) {
    on<AddCoinEvent>((event, emit) {
      final List<String> updatedList = List.from(state);

      if (updatedList.contains(event.id)) {
        updatedList.remove(event.id);
      } else {
        updatedList.add(event.id);
      }

      _userBox.put('watchlist', updatedList);

      emit(updatedList);
    });
  }
}
