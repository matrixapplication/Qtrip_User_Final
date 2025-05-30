
import 'package:q_trip_user/domain/repository/getsocialmedia_repo.dart';
import 'package:q_trip_user/data/repository/getsocialmedia_repository_imp.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:q_trip_user/data/repository/auth_repository_imp.dart';
import 'package:q_trip_user/data/repository/google_repository_imp.dart';
import 'package:q_trip_user/data/repository/local_repository_imp.dart';
import 'package:q_trip_user/data/repository/notification_repository_imp.dart';
import 'package:q_trip_user/data/repository/payment_repository_imp.dart';
import 'package:q_trip_user/data/repository/profile_repository_imp.dart';
import 'package:q_trip_user/data/repository/setting_repository_imp.dart';
import 'package:q_trip_user/data/repository/trip_repository_imp.dart';
import 'package:q_trip_user/data/repository/wallet_repository_imp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/local/cache_consumer.dart';
import '../core/services/network/api_consumer.dart';
import '../domain/repository/address_repo.dart';
import '../domain/repository/auth_repo.dart';
import '../domain/repository/chat_repo.dart';
import '../domain/repository/google_repo.dart';
import '../domain/repository/local_repo.dart';
import '../domain/repository/notification_repo.dart';
import '../domain/repository/payment_repo.dart';
import '../domain/repository/profile_repo.dart';
import '../domain/repository/setting_repo.dart';
import '../domain/repository/trip_repo.dart';
import '../domain/repository/wallet_repo.dart';
import 'app_urls/app_url.dart';
import 'datasource/remote/dio/dio_client.dart';
import 'datasource/remote/dio/logging_interceptor.dart';
import 'repository/address_repository_imp.dart';
import 'repository/chat_repository_imp.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<GetSocialMediaRepository>(() => GetSocialMediaRepositoryImp(dioClient: getIt()));


  /// Core
  getIt.registerLazySingleton(() => DioClient(AppURL.kBaseURL, getIt(), loggingInterceptor: getIt(), cacheConsumer:  getIt()));


  /// Repository
  getIt.registerLazySingleton<LocalRepository>(() => LocalRepositoryImp(dioClient: getIt(),cacheConsumer: getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<SettingRepository>(() => SettingRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<AddressRepository>(() => AddressRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<GoogleRepository>(() => GoogleRepositoryImp());
  getIt.registerLazySingleton<TripRepository>(() => TripRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImp());
  getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<WalletRepository>(() => WalletRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImp(dioClient: getIt()));




  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LoggingInterceptor());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => CacheConsumer(secureStorage: getIt() ,sharedPreferences: getIt()));



  getIt.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true),);
  getIt.registerLazySingleton(() => ApiConsumer(getIt<Dio>(), getIt<PrettyDioLogger>(), getIt()));

}