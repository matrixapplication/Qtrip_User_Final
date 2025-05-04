part of 'get_social_media_cubit.dart';
class GetSocialMediaState {}

 class GetSocialMediaInitial extends GetSocialMediaState {}

class GetSocialMediaLoading extends GetSocialMediaState{}
class GetSocialMediaSuccess extends GetSocialMediaState{
 final ResponseModel<SocialMediaModel>? responseModel;

 GetSocialMediaSuccess(this.responseModel);
}
class GetSocialMediaError extends GetSocialMediaState{}