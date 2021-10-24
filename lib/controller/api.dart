// ignore_for_file: avoid_print

import 'dart:async';
import 'package:buildeo/controller/upload.dart';
import 'package:buildeo/model/user.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

const String baseUrl = "iteam-s.mg:8000";
const String baseUrlprotocol = 'http://' + baseUrl;
final UploadController uploadController = Get.put(UploadController());

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

  Future<List> listCommune() async {
    try {
      var response = await client.get(
        "/api/listcommune/",
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

  Future<List> updateStatus(status, motif, permis, user) async {
    try {
     var response = await client.post(
        "/api/updatestatus/",
        data: {"permis_id": permis, "status": status, "motif_status": motif, "user_id": user.id, "token": user.token});
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


   Future<List> uploadContent(
     User? user,
     int commune , buildType, buildAdresse, String filepath) async {
    try {
      List filetmp = filepath.split('/');
      String filename = filetmp[filetmp.length - 1];
      var formData = dio.FormData.fromMap({
        'user_id': user!.id,
        'token': user.token,
        'commune_id': commune,
        'build_type': buildType,
        'build_adress': buildAdresse,
        'file': await dio.MultipartFile.fromFile(filepath, filename: filename),
      });
      var response = await client.post(
        '/api/requestpermis/',
        data: formData,
        onSendProgress: (int sent, int total) {
          print(uploadController.uploadPourcent);
          uploadController.uploadPourcent = sent / total;
          uploadController.update();
        },
      );
      return [true, response.data];
    } on dio.DioError catch (err) {
      if (err.response!.statusCode == 403) {
        return [false, err.response!.data['status']];
      } else {
        return [false, err.response!.data['status']];
      }
    } catch (e) {
      print("8---: $e");
      return [false, "Verifier Votre Réseau"];
    }
  }

}
