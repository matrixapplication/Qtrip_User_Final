import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/routing/navigation_services.dart';
import '../../../../domain/logger.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../presentation/dialog/show_recharge_wallet_dialog.dart';
import '../../../model/base/error_response.dart';
import 'error_widget.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.cancel,errorMessage: tr(LocaleKeys.noConnection));
            case DioErrorType.connectionTimeout:
              return   ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.connectTimeout,errorMessage: tr(LocaleKeys.noConnection));
            case DioErrorType.receiveTimeout:
              return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.receiveTimeout,errorMessage: tr(LocaleKeys.noConnection));
            case DioErrorType.sendTimeout:
              return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.sendTimeout,errorMessage: tr(LocaleKeys.noConnection));
            case DioErrorType.unknown:
              return   ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.other,errorMessage: tr(LocaleKeys.noConnection),);
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {

                case 401:return  const ErrorModel(code:401 ,codeError: ErrorEnum.auth,errorMessage:  'Unauthorized');
                case 404:
                case 442:
                  {
                    try{
                      if(error.response?.data?['data']['charge_wallet'] !=null && error.response?.data?['data']['charge_wallet'] ==1){
                        showRechargeWalletDialog(NavigationService.navigationKey.currentContext!,mess: error.response?.data['message']??'',
                        wallet: double.tryParse(error.response?.data?['data']?['wallet']?.toString()??'0'),
                        tripPrice: double.tryParse(error.response?.data?['data']?['trip_price']?.toString()??'0')

                        );
                      }
                    }catch(e){
                      print("asdasdas3 catch${e.toString()}");

                    }
                    ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);

                    return errorResponse;
                  }
                case 500:
                case 503:return ErrorModel(code:error.response?.statusCode??0 ,codeError:  ErrorEnum.server,errorMessage:  error.response?.statusMessage??'server');
                default:
                  ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.message != null && errorResponse.message!.isNotEmpty) {
                    log('ApiErrorHandler', 'default ${error.response!.data}');
                    return  errorResponse;
                  } else {
                    return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.otherError,errorMessage: "Failed to load data - status code: ${error.response!.statusCode}");
                  }
              }
              break;

            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              throw UnimplementedError();
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        } else {
          return const ErrorModel(code:0 ,codeError: ErrorEnum.otherError,errorMessage: "Unexpected error occured");
        }
      } on FormatException catch (e) {
        return  ErrorModel(code:0 ,codeError:  ErrorEnum.otherError,errorMessage:  e.toString());
      }catch (e){
        return  ErrorModel(code:0 ,codeError: ErrorEnum.otherError,errorMessage:  e.toString());
      }
    } else {
      return  const ErrorModel(code:0 ,codeError:  ErrorEnum.otherError,errorMessage:  "is not a subtype of exception");
    }
  }
}
