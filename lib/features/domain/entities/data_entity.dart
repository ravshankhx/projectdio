import 'package:equatable/equatable.dart';

class DataModel extends Equatable {
  final String updatedAt;
  final String text;
  const DataModel({
    this.updatedAt = '',
    this.text = '',
  });
  DataModel.fromJson(Map<String, dynamic> map)
      : text = map['text'],
        updatedAt = map["updatedAt"];
  static Map toJson(DataModel dataModel) => {
        'text': dataModel.text,
        'updatedAt': dataModel.updatedAt,
      };
  @override
  List<Object?> get props => [
        updatedAt,
        text,
      ];
}
