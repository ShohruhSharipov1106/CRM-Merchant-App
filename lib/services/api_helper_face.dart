import 'dart:io';

import 'package:crm_merchant/constants/exports.dart';
import 'package:http/http.dart' as http;

class FaceApiData {
  static const String _url = "crm.creditexpress.uz:6262";
  static DateTime? _tokenGetDate;
  static String token = "";
  static const String _urlToken = "api/account/token";

  int getTokenRequest = 0;

  Future<ResponseData<String>> getData(
      String api, HttpMethod method, Map<String, Object>? params) async {
    if (method == HttpMethod.get) {
      return await _getMethod(api, params);
    } else {
      return await _postMethod(api, params);
    }
  }

  Future<ResponseData<String>> _getMethod(
      String api, Map<String, Object>? param) async {
    var url = _getUri(api, param);
    print("req send: url-> ${url.toString()}");
    http.Response res = await http.get(
      url,
      headers: await _getHeaders(withToken: true),
    );
    print("res recieved(${res.statusCode}): ${res.body}");
    if (res.statusCode == 200) {
      return ResponseData(true, res.body, "");
    } else if (res.statusCode == 401) {
      if (getTokenRequest > 2) {
        return ResponseData(false, "", "Incorrect token param");
      }
      getTokenRequest = getTokenRequest + 1;
      await getToken();
      return await _getMethod(api, param);
    } else {
      return ResponseData(false, "", res.body);
    }
  }

  Future<ResponseData<String>> _postMethod(
      String api, Map<String, Object>? param) async {
    var url = _getUri(api, null);

    String? request;
    if (param != null) {
      request = jsonEncode(param);
    }
    print("req send: url-> ${url.toString()}, param: $param");
    var res = await http.post(url, headers: await _getHeaders(), body: request);
    print("res recieved(${res.statusCode}): ${res.body}");
    if (res.statusCode == 200) {
      return ResponseData(true, res.body, "");
    } else if (res.statusCode == 401) {
      if (getTokenRequest > 2) {
        return ResponseData(false, "", "Incorrect token param");
      }
      getTokenRequest = getTokenRequest + 1;
      await getToken();
      return await _postMethod(api, param);
    } else {
      return ResponseData(false, "", res.body);
    }
  }

//  mago
//  4@f?V$3K
  ///
  /// TOKEN PAGE
  ///

  Future<ResponseData<String>> getToken(
      {String username = "", String passpord = ""}) async {
    var uri = _getUri(_urlToken, null);
    String _userName = username;
    String _password = passpord;
    if (username.isEmpty) {
      _userName = clientMainData.read('username');
      _password = clientMainData.read('password');
    }

    var param = json.encode({"userName": _userName, "password": _password});

    var response = await http.post(uri,
        headers: await _getHeaders(withToken: false), body: param);

    if (response.statusCode == HttpStatus.ok) {
      Map maps = jsonDecode(response.body);
      token = maps["token"].toString();
      return ResponseData(true, "", "");
    } else {
      return ResponseData(false, "", response.body);
    }
  }

  Uri _getUri(String apiUrl, Map<String, dynamic>? param) {
    try {
      if (param == null) {
        return Uri.https(_url, apiUrl);
      } else {
        return Uri.https(_url, apiUrl, param);
      }
    } catch (error) {
      print(error);
      return Uri.parse("uri");
    }
  }

  Future<Map<String, String>> _getHeaders({bool withToken = true}) async {
    if (withToken && (token.isEmpty || _tokenGetDate == null)) {
      await getToken();
      sleep(const Duration(seconds: 2));
    }
    return {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json",
      "content-type": "application/json",
      "Access-Control-Allow-Origin": "*"
    };
  }
}

class ResponseData<T> {
  ResponseData(this.isSuccess, this.result, this.errorMessage);
  bool isSuccess = false;
  T? result;
  String errorMessage = "";
}
