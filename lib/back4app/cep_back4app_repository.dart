import 'package:dio/dio.dart';

import '../model/cep_back4app_model.dart';

class CepBack4appRepository {
  var _dio = Dio();

  CepBack4appRepository() {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        "mcHAxcCOWYnkKv15VNINhfnndGjxOhPKNJi7rEao";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "aLzXIBg9ZTMVpt92ldwKkoCmDYlB2kBYJ08wrWF3";
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }

  Future<CepsBack4appModel> getCep() async {
    var url = "/cep";
    var result = await _dio.get(url);
    return CepsBack4appModel.fromJson(result.data);
  }

  Future<void> postCep(CepBack4appModel cepBack4appModel) async {
    try {
      await _dio.post("/cep", data: cepBack4appModel.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> putCep(CepBack4appModel cepBack4appModel) async {
    try {
      await _dio.put("/cep/${cepBack4appModel.objectId}",
          data: cepBack4appModel.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteCep(String objectId) async {
    try {
      await _dio.delete("/cep/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
