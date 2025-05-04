import 'package:q_trip_user/presentation/modules/get_social_media/get_social_media_cubit.dart';
import 'package:q_trip_user/presentation/modules/address/search/store_search_address_cubit.dart';
import 'package:q_trip_user/presentation/modules/address/store/store_address_cubit.dart';
import 'package:q_trip_user/presentation/modules/auth/login/login_cubit.dart';
import 'package:q_trip_user/presentation/modules/auth/otp/otp_cubit.dart';
import 'package:q_trip_user/presentation/modules/auth/register/register_cubit.dart';
import 'package:q_trip_user/presentation/modules/chat/chat_cubit.dart';
import 'package:q_trip_user/presentation/modules/home/home_cubit.dart';
import 'package:q_trip_user/presentation/modules/my_trips/my_trips_cubit.dart';
import 'package:q_trip_user/presentation/modules/promo/promo_cubit.dart';
import 'package:q_trip_user/presentation/modules/search/search_cubit.dart';
import 'package:q_trip_user/presentation/modules/select_car/select_car_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/about_us/about_us_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/change_password/change_password_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/contact_us/contact_us_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/notification/notifications_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/privacy_policy/privacy_policy_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/profile/profile_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/terms/terms_cubit.dart';
import 'package:q_trip_user/presentation/modules/setting/wallet/wallet_cubit.dart';
import 'package:q_trip_user/presentation/modules/trip/trip_cubit.dart';
import 'package:q_trip_user/presentation/sheet/cancel_response_picker/cancel_response_picker_cubit.dart';
import 'package:q_trip_user/presentation/sheet/country_picker/country_picker_cubit.dart';
import 'package:q_trip_user/presentation/sheet/rate_sheet/rate_cubit.dart';
import 'package:q_trip_user/presentation/sheet/report_sheet/report_cubit.dart';
import 'core/utils/location/location_helper.dart';
import 'data/injection.dart';
import 'domain/provider/local_auth_cubit.dart';

Future<void> init() async {
  // Bloc
  getIt.registerLazySingleton(() => LocalAuthCubit(logoutUseCase:  getIt(),clearUserDataUseCase: getIt(), isUserLoginUseCase: getIt(), getProfileUseCase: getIt(), deleteAccountUseCase: getIt(), updateFCMTokenUseCase: getIt()));
  getIt.registerLazySingleton(() => LoginViewModel(saveUserDataUseCase: getIt(), signInUseCase: getIt(), sendOtpUseCase:  getIt(),));
  getIt.registerLazySingleton(() => RegisterCubit(saveUserDataUseCase: getIt(), registerUseCase: getIt()));
  getIt.registerLazySingleton(() => CountryPickerCubit(getCountriesUseCase: getIt(), ));
  getIt.registerLazySingleton(() => OtpViewModelCubit(saveUserDataUseCase: getIt(), forgetPasswordUseCase: getIt(),otpUseCase:  getIt(),updateFCMTokenUseCase:  getIt()));

  ///local
  getIt.registerLazySingleton(() => HomeCubit(locationHelper: getIt(),getLastTripUseCase: getIt()));
  getIt.registerLazySingleton(() => SearchCubit(getPlaceDetailsUseCase: getIt(),getPlacesUseCase: getIt(),getAddressesUseCase: getIt()));
  getIt.registerLazySingleton(() => SelectCarCubit(storeTripUseCase: getIt(),getDirectionUseCase: getIt(),getVehiclesUseCase: getIt(),));
  getIt.registerLazySingleton(() => StoreSearchAddressCubit(getPlacesUseCase:  getIt()));
  getIt.registerLazySingleton(() => StoreAddressCubit(storeAddressUseCase: getIt(), updateAddressUseCase:  getIt(), deleteAddressUseCase: getIt()));
  getIt.registerLazySingleton(() => TripCubit(locationHelper:  getIt(),getDirectionUseCase: getIt(),getMyLiveTripUseCase: getIt(),getMyLiveDriverUseCase: getIt(), geMyOffersTripUseCase: getIt(), acceptTripUseCase: getIt(), getDistanceTripUseCase: getIt()));
  getIt.registerLazySingleton(() => CancelResponsePickerCubit(cancelTripUseCase: getIt(),getCancelReasonsUseCase: getIt()));
  getIt.registerLazySingleton(() => RateSheetCubit(rateTripUseCase: getIt()));
  getIt.registerLazySingleton(() => ChatCubit(getMyLiveTripUseCase: getIt(),sendMessageUseCase: getIt(),getMessagesUseCase: getIt()));
  getIt.registerLazySingleton(() => PromoCubit(checkPromoCodeUseCase: getIt(),getPromoCodesUseCase: getIt()));
  getIt.registerLazySingleton(() => AboutUsCubit(getAboutUseCase: getIt()));
  getIt.registerLazySingleton(() => ContactUsCubit(contactUsRequestUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => PrivacyPolicyCubit(getPrivacyUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => TermsCubit(getTermsUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => ReportSheetCubit(reportTripUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => ProfileCubit(updateProfileImageUseCase:  getIt(), updateProfileUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => ChangePasswordCubit(changePasswordUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => WalletCubit(getWalletHistoryUseCase:  getIt(), rechargeWalletUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => MyTripsCubit(getTripsUseCase:  getIt(), ));
  getIt.registerLazySingleton(() => NotificationsCubit(getNotificationsUseCase:  getIt(), ));



  getIt.registerLazySingleton(() => LocationHelper());
  getIt.registerLazySingleton(() => GetSocialMediaCubit(getSocialMediaUseCase: getIt()));
}
