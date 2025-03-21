import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/src/media_type.dart' as m;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/global_var.dart';
import '../../../app/utils/utils.dart';
import 'api_endpoint.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);

  final _client = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      followRedirects: true,
      maxRedirects: 3,
      connectTimeout: const Duration(milliseconds: 120 * 1000),
      receiveTimeout: const Duration(milliseconds: 120 * 1000)));

  APIProvider() {
    _client.interceptors.add(DioLogInterceptor());
  }

  Future baseGetAPI(url, query, auth, context,
      {successMsg, loading, bool direct = false, String? fullUrl}) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    if (loading == true && loading != null) {
      dialog.show(
          indicatorColor: AppColors.primary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }

    log(fullUrl ?? (ApiEndPoints.baseUrl + url));
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("[APIProvider.baseGetAPI Authed] called with : ${Globals.authToken}");
        response = await _client.get(
          fullUrl ?? (ApiEndPoints.baseUrl + url),
          options: Options(headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': "Bearer ${Globals.authToken}"
          }),
          // queryParameters: query as Map<String, dynamic>
        );
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("[APIProvider.baseGetAPI unAuthed] called");
        response = await _client.get(
          fullUrl ?? (ApiEndPoints.baseUrl + url),
          options: Options(
              headers: <String, String>{'Content-Type': 'application/json'}),
        );
      }
      dialog.hide();
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      if (e.response != null) {
        dialog.hide();
        return _returnResponse(e.response!);
      } else {
        dialog.hide();
        return "No internet connection";
      }
    }
  }

  Future checkStatusAPI(url, auth, context,
      {successMsg, loading, bool direct = false, String? fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("[APIProvider.baseGetAPI Authed] called with : ${Globals.authToken}");
        response = await _client.get(fullUrl ?? (ApiEndPoints.baseUrl + url),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("[APIProvider.baseGetAPI unAuthed] called");
        response = await _client.get(fullUrl ?? (ApiEndPoints.baseUrl + url),
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return response.statusCode;
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.statusCode);
      }
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return e.response?.statusCode;
        } else {
          return e.response?.statusCode;
        }
      } else {
        return e.response?.statusCode;
      }
    }
  }

  Future basePostAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false, fullUrl}) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    if (loading == true && loading != null) {
      dialog.show(
          indicatorColor: AppColors.primary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log(jsonEncode(body));
        log("auth true");
        log("auth token...${Globals.authToken}");
        response = await _client.post(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}",
            }));
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("auth false");
        log(jsonEncode(body));
        response = await _client.post(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      dialog.hide();
      log(response.toString());
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      // log(e.toString());
      // // return _returnResponse(e.response);
      //
      // log(e.toString());

      Utils.showToast(message: 'Try again Later');

      dialog.hide();
      // pr.close();
      if (e.response?.data.runtimeType == String) {
        dialog.hide();
        // pr.close();
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          dialog.hide();
          // pr.close();
          // Utils().showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        dialog.hide();

        // pr.close();
        // return e.response?.data;
        return _returnResponse(e.response);
      }
    }
  }

  Future tokenPostApi(body, context, {successMsg, loading}) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    if (loading == true && loading != null) {
      dialog.show(
          indicatorColor: AppColors.primary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }
    try {
      Response response;
      log(jsonEncode(body));
      response = await _client.post("https://api.sandbox.checkout.com/tokens",
          data: body,
          options: Options(headers: <String, String>{
            'authorization': "pk_sbox_2mhlxi24rr6fyjngblns6phbqmw",
          }));
      dialog.hide();
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      dialog.hide();
      // pr.close();
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        dialog.hide();
        // pr.close();
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          dialog.hide();
          // pr.close();
          // Utils().showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        dialog.hide();
        // pr.close();
        return e.response?.data;
      }
    }
  }

  Future basePutAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false, fullUrl}) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    if (loading == true && loading != null) {
      dialog.show(
          indicatorColor: AppColors.primary,
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }
    try {
      Response response;
      if (auth == null || auth == true) {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log(jsonEncode(body));
        log("auth true");
        response = await _client.patch(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        log(fullUrl ?? (ApiEndPoints.baseUrl + url));
        log("auth false");
        log(jsonEncode(body));
        response = await _client.put(fullUrl ?? (ApiEndPoints.baseUrl + url),
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      dialog.hide();
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      dialog.hide();
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future baseDeleteAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false}) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    if (loading == true && loading != null) {
      dialog.show(
          message: 'Loading...',
          type: SimpleFontelicoProgressDialogType.normal);
    }

    try {
      Response response;
      if (auth == null || auth == true) {
        log(ApiEndPoints.baseUrl + url);
        log(jsonEncode(body));
        log("auth true");
        response = await _client.delete(ApiEndPoints.baseUrl + url,
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        log(ApiEndPoints.baseUrl + url);
        log("auth false");
        log(jsonEncode(body));
        response = await _client.delete(ApiEndPoints.baseUrl + url,
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      dialog.hide();
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeOutException(null);
    } on SocketException {
      dialog.hide();
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      dialog.hide();
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          dialog.hide();
          // Utils.showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        dialog.hide();
        return e.response?.data;
      }
    }
  }

  Future baseMultiPartAPI(url, body, auth, context, File file, String fileType,
      {successMsg,
      loading,
      bool direct = false,
      Function(int sent, int total)? progress}) async {
    String fileName = file.path.split("/").last;
    try {
      FormData? formData;
      _client.options.headers
          .addAll({"authorization": "Bearer ${Globals.authToken}"});
      Response response;
      formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType:
                m.MediaType(fileType, fileName.split(".").last.toLowerCase())),
      });
      response = await _client.post(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          log('$sent : $total');
          if (progress != null) {
            progress(sent, total);
          }
        },
      );

      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      log(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          // Utils.showBottomSheetWidget();
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future baseMultipartPersonalInfo(
    String url,
    Map<String, dynamic> body,
    File storeLogo,
    context, {
    Function(int sent, int total)? progress,
  }) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "avatar": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
                m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw const SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }

  Future baseMultipartPersonalInfoPatch(
    String url,
    Map<String, dynamic> body,
    File storeLogo,
    context, {
    Function(int sent, int total)? progress,
  }) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context!);
    dialog.show(
        indicatorColor: AppColors.primary,
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.normal);
    String storeName = storeLogo.path.split("/").last;
    _client.options.headers
        .addAll({"authorization": "Bearer ${Globals.authToken}"});
    try {
      var formData = FormData.fromMap({
        ...body,
        "avatar": await MultipartFile.fromFile(storeLogo.path,
            filename: storeName,
            contentType:
                m.MediaType('image', storeName.split(".").last.toLowerCase())),
      });
      Response response = await _client.patch(
        ApiEndPoints.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (progress != null) {
            progress(sent, total);
          }
        },
      );
      dialog.hide();
      return response.data;
    } on TimeoutException catch (_) {
      dialog.hide();
      throw TimeoutException("Request timed out");
    } on SocketException {
      dialog.hide();
      throw const SocketException("No Internet connection");
    } on DioException catch (e) {
      dialog.hide();
      if (e.response?.data is String && e.response?.data.contains("limit")) {
        return null;
      } else {
        return e.response?.data ?? {"statusCode": 401};
      }
    }
  }

  dynamic _returnResponse(Response<dynamic>? response) {
    switch (response?.statusCode) {
      case 200:
        log("200");
        // print(response.data);
        return response?.data;
      case 201:
        log("201");
        // print(response.data);
        return response?.data;
      case 400:
        if (response?.data['error'] != null) {
          Utils.showToast(message: response?.data['error']);
        } else {
          Utils.showToast(message: response?.data['data']['error']);
        }
        throw BadRequestException(response?.data.toString());
      case 401:
        // refreshToken();
        // _client.close();
        // token issue\

        if (response?.data['code'] == 'token_not_valid') {
          Utils.showToast(message: 'Session Expired');
        }
        // g.Get.offAllNamed(Routes.SIGNIN_ACCOUNT);
        // return response?.data;

        throw BadRequestException(response?.data.toString());
      case 403:
        if (response?.data['error'] != null) {
          Utils.showToast(message: response?.data['error']);
        } else {
          Utils.showToast(message: response?.data['data']['error']);
        }
        throw UnauthorisedException(response?.data.toString());
      case 404:
        if (response?.data['error'] != null) {
          Utils.showToast(message: response?.data['error']);
        } else {
          Utils.showToast(message: response?.data['data']['error']);
        }
        throw BadRequestException('Not found');
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        log("default");
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response?.statusCode}');
    }
  }

// refreshToken() async {

// }
}

class AppException implements Exception {
  final code;
  String? message;
  final details;

  AppException({this.code, this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
          code: "unauthorised",
          message: "Unauthorised",
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
