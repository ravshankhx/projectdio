import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:untitled4/features/data/repositories/repository_impl.dart';
import 'package:untitled4/features/domain/entities/data_entity.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final Repository repository = Repository();
  DataBloc() : super(const DataState()) {
    on<DataEvent>((event, emit) async {
      emit(state.copyWith(dataStatus: FormzSubmissionStatus.inProgress));
      final result = await repository.getData();
      print(result);
      if (result.isNotEmpty) {
        emit(state.copyWith(
          dataStatus: FormzSubmissionStatus.success,
          list: result,
        ));
      } else {
        emit(state.copyWith(dataStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
