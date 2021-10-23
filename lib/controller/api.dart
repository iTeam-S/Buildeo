// ignore_for_file: avoid_print

import 'dart:async';
import 'package:buildeo/model/user.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

const String baseUrl = "192.168.179.73:8000";
const String baseUrlprotocol = 'http://' + baseUrl;

class ApiController extends GetxController {
  var client = dio.Dio(dio.BaseOptions(
    baseUrl: baseUrlprotocol,
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

  Future<List> login(usr, passwd) async {
    try {
      var response = await client.post(
        "/api/login/",
        data: {"usr": usr, "passwd": passwd},
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

  Future<List> getallpermis(int? commune, User user) async {
    try {
      var response = await client.post(
        "/api/listpermit/",
        data: {"commune_id": commune, "user_id": user.id, "token": user.token},
      );
      print(response.data);
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