part of 'data_bloc.dart';

class DataState extends Equatable {
  final FormzSubmissionStatus dataStatus;
  final List<DataModel> list;
  const DataState({
    this.dataStatus = FormzSubmissionStatus.initial,
    this.list = const [],
  });

  DataState copyWith({
    FormzSubmissionStatus? dataStatus,
    List<DataModel>? list,
  }) =>
      DataState(
        dataStatus: dataStatus ?? this.dataStatus,
        list: list ?? this.list,
      );
  @override
  List<Object?> get props => [
        dataStatus,
        list,
      ];
}
