import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import '../features/dialogs/error_dialog.dart';
import '../features/dialogs/loading_dialog.dart';
import '../utils.dart';
import 'api_endpoints.dart';

class HttpClient {
  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  static Map<String, String> getHeaders() {
    var header = <String, String>{
      // "Authorization": "Bearer ${PreferenceManager.getString(PreferenceManager.bearerToken)}",
      "Accept": "application/json",
      "content-type": "application/json",
    };
    print(header);
    return header;
  }

  Future<Response> getRequest(String path) async {
    LoadingDialog.showProgressIndicatorAlertDialog();
    Response response = await get(
      Uri.parse(ApiEndpoints.baseUrl + path),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    print(ApiEndpoints.baseUrl + path);
    LoadingDialog.removeProgressIndicatorAlertDialog();
    prettyPrintJson(response.body);

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            LoadingDialog.removeProgressIndicatorAlertDialog();
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstant.loginScreen);
              });
        }
        break;

      case 200:
        var decode = json.decode(response.body);
        // switch (decode['statusCode']) {
        //   case 500:
        //     {
        //       ErrorDialog.showErrorDialog(
        //           errorText: decode['message'],
        //           onPressed: () {
        //             Get.back();
        //           });
        //     }
        //     break;
        // }
    }
    return response;
  }
  Future<Response> deleteRequest(String path) async {
    try {
      // Show loading dialog
      LoadingDialog.showProgressIndicatorAlertDialog();

      final response = await delete(
        Uri.parse(ApiEndpoints.baseUrl + path),
        headers: getHeaders(),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Remove loading dialog
          LoadingDialog.removeProgressIndicatorAlertDialog();
          throw TimeoutException('Can\'t connect in 30 seconds.');
        },
      );

      // Remove loading dialog
      LoadingDialog.removeProgressIndicatorAlertDialog();

      // Log request and response details
      print('Request URL: ${ApiEndpoints.baseUrl + path}');
      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      // Handle different status codes
      switch (response.statusCode) {
        case 500:
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
          break;

        case 401:
          ErrorDialog.showErrorDialog(
            errorText: "Your Session is Expired, You Need to Login Again.",
            onPressed: () {
              // Navigate to login screen
              // Get.offAllNamed(PageRouteConstant.loginScreen);
            },
          );
          break;

        case 204:
          print('Got 204 No Content');
          // No need to decode response.body here since it's empty
          break;

        default:
        // Handle other status codes if needed
          break;
      }

      return response;
    } catch (e) {
      // Log and rethrow the error
      print('An error occurred: $e');
      throw e;
    }
  }

  Future<Response> postRequest(String path, {Map<dynamic, dynamic>? body}) async {
    LoadingDialog.showProgressIndicatorAlertDialog();

    print(ApiEndpoints.baseUrl + path);
    // print(getHeaders());
    prettyPrintMap(body);

    Response response = await post(
      Uri.parse(ApiEndpoints.baseUrl + path),
      body: jsonEncode(body),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    LoadingDialog.removeProgressIndicatorAlertDialog();

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;
      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstant.loginScreen);
              });
        }
        break;

      case 400:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Form is Invalid",
              onPressed: () {
                Get.back();
              });
        }
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }

    prettyPrintMap(response.headers);
    prettyPrintJson(response.body);
    return response;
  }

  Future<Response> putRequest(String path, {Map<dynamic, dynamic>? body}) async {
    LoadingDialog.showProgressIndicatorAlertDialog();
    Future<Response> putRequest(String path, {Map<dynamic, dynamic>? body}) async {
      LoadingDialog.showProgressIndicatorAlertDialog();

      print(ApiEndpoints.baseUrl + path);
      // print(getHeaders());
      prettyPrintMap(body);

      Response response = await put(
        Uri.parse(ApiEndpoints.baseUrl + path),
        body: jsonEncode(body),
        headers: getHeaders(),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          LoadingDialog.removeProgressIndicatorAlertDialog();
          throw TimeoutException('Can\'t connect in 30 seconds.');
        },
      );

      LoadingDialog.removeProgressIndicatorAlertDialog();

      switch (response.statusCode) {
        case 500:
          {
            ErrorDialog.showErrorDialog(onPressed: () {
              Get.back();
            });
          }
          break;

        case 401:
          {
            ErrorDialog.showErrorDialog(
                errorText: "Your Session is Expired, You Need to Login Again. ",
                onPressed: () {
                  // Get.offAllNamed(PageRouteConstant.loginScreen);
                });
          }
          break;

        case 400:
          {
            ErrorDialog.showErrorDialog(
                errorText: "Form is Invalid",
                onPressed: () {
                  Get.back();
                });
          }
          break;

        case 200:
          var decode = json.decode(response.body);
          switch (decode['statusCode']) {
            case 500:
              {
                ErrorDialog.showErrorDialog(
                    errorText: decode['message'],
                    onPressed: () {
                      Get.back();
                    });
              }
              break;
          }
      }

      prettyPrintMap(response.headers);
      prettyPrintJson(response.body);
      return response;
    }

    print(ApiEndpoints.baseUrl + path);
    // print(getHeaders());
    prettyPrintMap(body);

    Response response = await put(
      Uri.parse(ApiEndpoints.baseUrl + path),
      body: jsonEncode(body),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    //
    LoadingDialog.removeProgressIndicatorAlertDialog();

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstant.loginScreen);
              });
        }
        break;

      case 400:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Form is Invalid",
              onPressed: () {
                Get.back();
              });
        }
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }
    prettyPrintMap(response.headers);
    prettyPrintJson(response.body);
    return response;
  }

  Future<Response> putRequestWithoutLoader(String path, {Map<dynamic, dynamic>? body}) async {
    Future<Response> putRequest(String path, {Map<dynamic, dynamic>? body}) async {


      print(ApiEndpoints.baseUrl + path);
      // print(getHeaders());
      prettyPrintMap(body);

      Response response = await put(
        Uri.parse(ApiEndpoints.baseUrl + path),
        body: jsonEncode(body),
        headers: getHeaders(),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Can\'t connect in 30 seconds.');
        },
      );

      switch (response.statusCode) {
        case 500:
          {
            ErrorDialog.showErrorDialog(onPressed: () {
              Get.back();
            });
          }
          break;

        case 401:
          {
            ErrorDialog.showErrorDialog(
                errorText: "Your Session is Expired, You Need to Login Again. ",
                onPressed: () {
                  // Get.offAllNamed(PageRouteConstant.loginScreen);
                });
          }
          break;

        case 400:
          {
            ErrorDialog.showErrorDialog(
                errorText: "Form is Invalid",
                onPressed: () {
                  Get.back();
                });
          }
          break;

        case 200:
          var decode = json.decode(response.body);
          switch (decode['statusCode']) {
            case 500:
              {
                ErrorDialog.showErrorDialog(
                    errorText: decode['message'],
                    onPressed: () {
                      Get.back();
                    });
              }
              break;
          }
      }

      prettyPrintMap(response.headers);
      prettyPrintJson(response.body);
      return response;
    }

    print(ApiEndpoints.baseUrl + path);
    // print(getHeaders());
    prettyPrintMap(body);

    Response response = await put(
      Uri.parse(ApiEndpoints.baseUrl + path),
      body: jsonEncode(body),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {

        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    //


    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstant.loginScreen);
              });
        }
        break;

      case 400:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Form is Invalid",
              onPressed: () {
                Get.back();
              });
        }
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }
    prettyPrintMap(response.headers);
    prettyPrintJson(response.body);
    return response;
  }
}
