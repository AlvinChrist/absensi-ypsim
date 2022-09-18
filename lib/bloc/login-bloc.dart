import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/dio-interceptor.dart';
import 'package:material_kit_flutter/models/login.dart';
import 'package:material_kit_flutter/widgets/spinner.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login-result.dart';

class LoginBloc {
  bool state = true;
  late BehaviorSubject<bool> _obscureText$;
  Map<String, dynamic> model = new Login().toJson();
  Spinner sp = Spinner();
  LoginBloc() {
    _obscureText$ = BehaviorSubject<bool>.seeded(true);
  }

  Stream<bool> get counterObservable {
    return _obscureText$.stream;
  }

  toggle() {
    state = !state;
    _obscureText$.sink.add(state);
  }

  saveCredentials(LoginResult cred) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('user', jsonEncode(cred.toJson()));
  }

  Future<bool> loginUser(BuildContext context) async {
    sp.show(context: context);
    try {
      Response resp = await login();
      await saveCredentials(LoginResult.fromJson(resp.data.Result));
      sp.hide();
      return true;
    } catch (e) {
      sp.hide();
      String error = "";
      if(e is DioError) {
        if(e.response != null) {
          error = "${e.message}\n${e.response != null ? e.response!.data['Message'] : e.response.toString()}";
        } else if(e.error is SocketException) {
          error = "Tidak ada koneksi";
        } else if(e.error is TimeoutException) {
          error = "${e.requestOptions.baseUrl}${e.requestOptions.path}\nRequest Timeout";
        }
      } else {
        error = e.toString();
      }
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Gagal",
          text: error
        )
      );
      return false;
    }
  }

  Future<Response> login() {
    return DioClient().dio.post('/login', data: model);
  }
  
  void dispose() {
    _obscureText$.close();
  }
}
