

import 'package:q_trip_user/domain/logger.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app.dart';
import '../../core/services/local/cache_consumer.dart';
import '../../core/services/local/storage_keys.dart';
import '../../domain/repository/local_repo.dart';
import '../../presentation/dialog/show_langauge_dialog.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
class LocalRepositoryImp implements LocalRepository {
  final DioClient? _dioClient;
  final CacheConsumer _cacheConsumer;

  LocalRepositoryImp({
    required DioClient? dioClient,
    required CacheConsumer cacheConsumer,
  })  : _dioClient = dioClient,
        _cacheConsumer = cacheConsumer;


  // for  user token
  @override
  Future<bool> saveSecuredData(String token) async {
    await _cacheConsumer.saveSecuredData(StorageKeys.kToken, token);
    log('saveSecuredData', 'token :$token');
    _dioClient!.token = token;
    _dioClient!.dio!.options.headers = {
      'Accept': 'application/json; charset=UTF-8',
      'x-api-key': AppURL.kAPIKey,
      'Content-Language': kLangCode??appContext?.locale.languageCode ?? 'en',
      'Authorization': 'Bearer $token'
    };

    return await _cacheConsumer.save(StorageKeys.kIsAuthed, true) ;
  }

  @override
  Future<String> getUserToken() async {
    return await _cacheConsumer.getSecuredData(StorageKeys.kToken)??'';
  }

  @override
  bool isLoggedIn() {
    return _cacheConsumer.get(StorageKeys.kIsAuthed) ?? false;
  }

  @override
  Future<bool> clearSharedData() async {
    _cacheConsumer.deleteSecuredData();
    _cacheConsumer.delete(StorageKeys.kIsAuthed);
    return _cacheConsumer.delete(StorageKeys.kToken);
  }

}
