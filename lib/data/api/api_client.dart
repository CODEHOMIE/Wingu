

import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as http;

import '../../util/export_files.dart';




class ApiClient extends GetxService {
   String appBaseUrl = AppConstants.baseUrl ;
  final SharedPreferences sharedPreferences;
  final String noInternetMessage = 'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;
  String token ='';
  Map<String, String> _mainHeaders ={};

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  })
  {
    print(" token.............................................$token");

    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

   void updateHeader(String token) {
     _mainHeaders = {
       'Content-Type': 'application/json; charset=UTF-8',
       'Authorization': 'Bearer $token',
     };

   }

   Future<Response> getWithParamData(
    String uri, {
    required Map<String, String> queryParams,
  }) async {
    try {
      debugPrint(
          '====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
      if (Foundation.kDebugMode) {
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
      }
      http.Response _response = await http.get(
        Uri.parse(appBaseUrl + uri).replace(queryParameters: queryParams),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
      }
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

   Future<Response> getData(String uri, {required Map<String, dynamic> query, }) async {
    if(await ApiChecker.isVpnActive()) {
      return const Response(statusCode: -1, statusText: 'you are using vpn');
    }else{
      try {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        http.Response response = await http.get(
          Uri.parse(uri),
          headers:_mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        return handleResponse(response, uri);
      } catch (e) {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }

    }
   }

  Future<Response> postData(
      String uri, dynamic body,) async {
    if(await ApiChecker.isVpnActive()) {
      return Response(statusCode: -1, statusText: 'you are using vpn');
    }{
      try {
        if(Foundation.kDebugMode){
          print('====> GetX Base URL: $appBaseUrl');
          print('====> GetX Call: $uri');
          print('====> GetX Body: $body');
        }
        http.Response _response = await http.post(
          Uri.parse(appBaseUrl+uri),
          body: jsonEncode(body),
          headers: _mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        print("++++++++++++>>>=====");
        Response response = handleResponse(_response, uri);

        if(Foundation.kDebugMode) {
          print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
        }
        return response;
      } catch (e) {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }

    }
  }


   Response handleResponse(http.Response response, String uri) {
     dynamic body;
     try {
       body = jsonDecode(response.body);
     }catch(e) {}
     Response _response = Response(
       body: body ?? response.body, bodyString: response.body.toString(),
       request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
       headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
     );
     if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
       if(_response.body.toString().startsWith('{errors: [{code:')) {
         ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
         _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
       }else if(_response.body.toString().startsWith('{message')) {
         _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
       }
     }else if(_response.statusCode != 200 && _response.body == null) {
       _response = Response(statusCode: 0, statusText: noInternetMessage);
     }
     debugPrint('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
     return _response;
   }

 }
