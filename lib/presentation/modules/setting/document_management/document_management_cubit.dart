// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:q_trip_user_captain/domain/entities/drop_down_entity.dart';
// import 'package:q_trip_user_captain/domain/entities/user_entity.dart';
// import 'package:q_trip_user_captain/domain/usecase/profile/get_profile_usecase.dart';
// import 'package:q_trip_user_captain/domain/usecase/profile/update_document_usecase.dart';
//
// import '../../../../core/utils/globals.dart';
// import '../../../../data/model/base/response_model.dart';
// import '../../../../domain/request_body/document_body.dart';
// import '../../../../domain/request_body/profile_body.dart';
// import '../../../../domain/usecase/local/save_data_usecase.dart';
// import '../../../../domain/usecase/profile/update_profile_image_usecase.dart';
// import '../../../../domain/usecase/profile/update_profile_usecase.dart';
// import '../../../component/inputs/phone_country/countries.dart';
//
// part 'document_management_state.dart';
//
// class DocumentManagementCubit extends Cubit<DocumentManagementState> {
//
//   final UpdateDocumentUseCase _updateDocumentUseCase;
//   final GetProfileUseCase _getProfileUseCase;
//
//   DocumentManagementCubit({
//     required UpdateDocumentUseCase updateDocumentUseCase,
//     required GetProfileUseCase getProfileUseCase,
//
//   })  : _updateDocumentUseCase = updateDocumentUseCase,_getProfileUseCase = getProfileUseCase,_body = DocumentBody.init(),
//         super(DocumentManagementInitial());
//
//   ///variables
//   DocumentBody _body ;
//
//   ///getters
//   DocumentBody get body => _body;
//
//
//   ///update data
//   //on update profile image
//   updateDriverLicenseImageFront(String? path) {_body.updateDriverLicenseImageFront(path);emit(DocumentManagementInitial());}
//   updateDriverLicenseImageBack(String? path) {_body.updateDriverLicenseImageBack(path);emit(DocumentManagementInitial());}
//
//   updateNationalIdImageFront(String? path) {_body.updateNationalIdImageFront(path);emit(DocumentManagementInitial());}
//   updateNationalIdImageBack(String? path) {_body.updateNationalIdImageBack(path);emit(DocumentManagementInitial());}
//
//
//
//   ///calling APIs Functions
//   Future<ResponseModel> updateDocumentManagement({required String licenseNumber, required String licenseDueDate}) async {
//     emit(DocumentManagementLoading());
//     _body.setData(driverLicenseDueDate: licenseDueDate, driverLicenseNumber: licenseNumber);
//     ResponseModel<UserEntity> responseModel = await _updateDocumentUseCase(body: _body);
//     _body = DocumentBody.init();
//     emit(DocumentManagementInitial());
//     return responseModel;
//   }
//
//   Future<ResponseModel> getUser() async {
//     emit(DocumentManagementProfileLoading());
//     ResponseModel responseModel = await _getProfileUseCase();
//     if (responseModel.isSuccess) {
//       kUser = responseModel.data;
//       _body = DocumentBody.init();
//
//     }
//     emit(DocumentManagementInitial());
//
//     return responseModel;
//   }
// }
