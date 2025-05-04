import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/social_medail_model.dart';
import '../../../domain/usecase/getsocialmedia/getsocialmedia_usecase.dart';
part 'get_social_media_state.dart';

class GetSocialMediaCubit extends Cubit<GetSocialMediaState> {
  final GetSocialMediaUseCase getSocialMediaUseCase;
  GetSocialMediaCubit({required this.getSocialMediaUseCase}) : super(GetSocialMediaInitial());
  SocialMediaModel? socialMediaModel;

  getSocialMediaLinks({required bool reload,}) async {
    if(reload)emit(GetSocialMediaLoading());
    try{
      final responseModel =await getSocialMediaUseCase();
      if(responseModel.isSuccess){
        socialMediaModel =responseModel.data;
        emit(GetSocialMediaSuccess(responseModel));
      }else{
        emit(GetSocialMediaError());
      }

    }catch(e){
      emit(GetSocialMediaError());

    }
  }
}
      