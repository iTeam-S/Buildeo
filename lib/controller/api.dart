import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

const String base_url = "192.168.137.86:8000";
const String base_url_protocol = 'http://' + base_url;

class ApiController extends GetxController {
  var client = dio.Dio(dio.BaseOptions(
    baseUrl: base_url_protocol,
  ));

  Future<List> getPermis(numPermis) async {
    try {
      var response = await client.post(
        "/api/permis/",
        data: {"numero_permis": numPermis},
      );
      return [true, response.data];
    } on dio.DioError catch (err) {
      if (err.response!.statusCode == 403) {
        return [false, err.response!.data['status']];
      } else {
        return [false, err.message];
      }
    } catch (e) {
      print(e);
      return [false, "Une erreur s'est produite"];
    }
  }
}