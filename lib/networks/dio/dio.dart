import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:location_tracker/common_widgets/custom_toast.dart';
import 'package:location_tracker/constants/app_constants.dart';
import 'package:location_tracker/helpers/all_routes.dart';
import 'package:location_tracker/helpers/di.dart';
import 'package:location_tracker/helpers/navigation_service.dart';
import 'package:location_tracker/networks/endpoints.dart';
import 'log.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;
  static bool _isLoggingOut = false;

  void create() {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.ACCEPT_LANGUAGE: appData.read(kKeyCountryCode) ?? "pt",
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
      },
    );

    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) {
            if (_isGlobalError(error)) {
              _handleGlobalError(error);
              return handler.reject(error);
            }
            return handler.next(error);
          },
        ),
      );
  }

  void update(String auth) {
    if (kDebugMode) {
      print("Dio update with auth token");
    }
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.AUTHORIZATION: "Bearer $auth",
      },
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );

    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) {
            if (_isGlobalError(error)) {
              _handleGlobalError(error);
              return handler.reject(error);
            }
            return handler.next(error);
          },
        ),
      );
  }

  bool _isGlobalError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 401 ||
        error.response?.statusCode == 403 ||
        error.response?.statusCode == 500 ||
        error.response?.statusCode == 502 ||
        error.response?.statusCode == 503;
  }

  void _handleGlobalError(DioException error) {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      performForceLogout();
    }
  }

  /// Global Force Logout / Session Expiration Handler
  static void performForceLogout() {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    // 1. Wipe local session & credentials
    appData.erase();

    // 2. Reset Dio client to unauthenticated state
    DioSingleton.instance.create();

    // 3. Inform user
    customToastMessage(
      "Session Expired",
      "Your session has expired. Please log in again.",
    );

    // 4. Force navigation to login screen, clearing entire backstack
    NavigationService.navigateToUntilReplacement(Routes.logInScreen);

    // Release debounce lock after navigation completes
    Future.delayed(const Duration(seconds: 2), () {
      _isLoggingOut = false;
    });
  }
}

Future<Response> postHttp(String path, [dynamic data]) => DioSingleton
    .instance
    .dio
    .post(path, data: data, cancelToken: DioSingleton.cancelToken);

Future<Response> putHttp(String path, [dynamic data]) => DioSingleton
    .instance
    .dio
    .put(path, data: data, cancelToken: DioSingleton.cancelToken);

Future<Response> patchHttp(String path, [dynamic data]) => DioSingleton
    .instance
    .dio
    .patch(path, data: data, cancelToken: DioSingleton.cancelToken);

Future<Response> getHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.get(path, cancelToken: DioSingleton.cancelToken);

Future<Response> deleteHttp(String path, [dynamic data]) => DioSingleton
    .instance
    .dio
    .delete(path, data: data, cancelToken: DioSingleton.cancelToken);
