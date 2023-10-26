import 'package:dio/dio.dart';
import 'package:untitled4/features/domain/entities/data_entity.dart';

class Repository {
  final Dio dio = Dio(BaseOptions());

  Future<List<DataModel>> getData() async {
    final response = await dio.get("https://cat-fact.herokuapp.com/facts");

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return (response.data as List<dynamic>).map((e) => DataModel.fromJson(e)).toList();
    } else {
      throw Exception("Error");
    }
  }
}
