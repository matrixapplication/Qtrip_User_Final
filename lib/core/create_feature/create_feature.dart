import 'dart:io';
import 'add_cubit_in_dependency.dart';
import 'add_cubit_in_generate_multi_bloc.dart';
import 'add_end_ppint.dart';
import 'add_repo_in_dependency.dart';
import 'add_usecase_in_dependency.dart';
import 'get_project_name.dart';

final projectName = getProjectName();

void main() {
  const String featureName = 'GetSocialMedia';
  const String featureFileName = 'get_social_media';
  final getEndPoint =addEndpoint(endpointName: '${featureName}sUrl', endpointValue: 'trips');
  // final addEndPoint =addEndpoint(endpointName: 'Add${featureName}sUrl', endpointValue: 'user/AddToasts');



  final targetDataPath = "${Directory.current.path}/lib/data";
  final targetDomainPath = "${Directory.current.path}/lib/domain";
  final targetPath = "${Directory.current.path}/lib/presentation/modules/$featureFileName";
  final directories = [
    '$targetDomainPath/usecase/${featureName.toLowerCase()}',
    '$targetPath/widgets',
  ];

  final files = [
    {
      'path': '$targetPath/${featureFileName.toLowerCase()}_screen.dart',
      'content': '''
import 'package:flutter/material.dart';
class ${featureName}Screen extends StatelessWidget {
  const ${featureName}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$featureName Screen'),
      ),
      body: const Center(
        child: Text('Welcome to $featureName Screen!'),
      ),
    );
  }
}
      '''
    },
    {
      'path': '$targetPath/${featureFileName}_cubit.dart',
      'content': '''
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part '${featureFileName.toLowerCase()}_state.dart';

class ${featureName}Cubit extends Cubit<${featureName}State> {
  ${featureName}Cubit() : super(${featureName}Initial());
}
      '''
    },
    {
      'path': '$targetPath/${featureFileName}_state.dart',
      'content': '''
part of '${featureFileName.toLowerCase()}_cubit.dart';
class ${featureName}State {}

class ${featureName}Initial extends ${featureName}State {}
      '''
    },
    {
      'path': '$targetDomainPath/usecase/${featureName.toLowerCase()}/${featureName.toLowerCase()}_usecase.dart',
      'content': '''
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/${featureName.toLowerCase()}_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class ${featureName}UseCase implements BaseUseCase<dynamic>{
  final ${featureName}Repository repository;
  ${featureName}UseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.get${featureName}(), onConvert,tag: '${featureName}UseCase');
  }

  @override
  ResponseModel<dynamic> onConvert(BaseModel baseModel) {
    try{
      return ResponseModel(baseModel.status??true, baseModel.message,data: baseModel.item);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}

      '''
    },
    {
      'path': '$targetDomainPath/repository/${featureName.toLowerCase()}_repo.dart',
      'content': '''

import '../../data/model/base/api_response.dart';
mixin ${featureName}Repository {
  Future<ApiResponse> get${featureName}() ;
}
      '''
    },
    {
      'path': '$targetDataPath/repository/${featureName.toLowerCase()}_repository_imp.dart',
      'content': '''

import 'dart:async';
import 'package:dio/dio.dart';
import '../../domain/repository/${featureName.toLowerCase()}_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class ${featureName}RepositoryImp implements ${featureName}Repository{
  final DioClient _dioClient;
  const ${featureName}RepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;

  @override
  Future<ApiResponse> get${featureName}() async{
    try {
      Response response = await _dioClient.get(
        AppURL.${getEndPoint},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

      '''
    }
  ];

  // إنشاء المجلدات
  for (var dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('Created directory: $dir ✔');
    } else {
      print('Directory already exists: $dir');
    }
  }

  // إنشاء الملفات بالقوالب
  for (var file in files) {
    final filePath = file['path']!;
    final fileContent = file['content']!;
    final newFile = File(filePath);

    if (!newFile.existsSync()) {
      newFile.createSync(recursive: true);
      newFile.writeAsStringSync(fileContent);
      print('Created file: $filePath ✔');
    } else {
      print('File already exists: $filePath');
    }
  }


  ///Block of code to be executed later
  addCubitInGenerateMultiBloc(featureName: featureName, projectName: projectName,featureFileName: featureFileName);

  /// injection.dart
  addCubitInDependency(featureName: featureName,dependencies: [],featureFileName: featureFileName);


  ///Add UseCase in dependency
  addUseCaseInDependency(featureName: featureName,);

  /// Add Repo
  addRepoInDependency(featureName:featureName);
}











