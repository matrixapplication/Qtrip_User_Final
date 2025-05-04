
import 'package:q_trip_user/domain/usecase/auth/send_otp_usecase.dart';
import 'package:q_trip_user/domain/usecase/getsocialmedia/getsocialmedia_usecase.dart';
import 'package:q_trip_user/domain/usecase/address/delete_address_usecase.dart';
import 'package:q_trip_user/domain/usecase/address/get_addresses_usecase.dart';
import 'package:q_trip_user/domain/usecase/address/store_address_usecase.dart';
import 'package:q_trip_user/domain/usecase/address/update_address_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/change_password_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/check_otp_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/delete_account_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/forget_password_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/logout_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/register_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/reset_password_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/sign_in_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/update_fcm_token_usecase.dart';
import 'package:q_trip_user/domain/usecase/google/get_direction_usecase.dart';
import 'package:q_trip_user/domain/usecase/google/get_place_details_usecase.dart';
import 'package:q_trip_user/domain/usecase/google/get_places_usecase.dart';
import 'package:q_trip_user/domain/usecase/local/clear_user_data_usecase.dart';
import 'package:q_trip_user/domain/usecase/local/get_is_login_usecase.dart';
import 'package:q_trip_user/domain/usecase/local/get_user_token_usecase.dart';
import 'package:q_trip_user/domain/usecase/local/save_data_usecase.dart';
import 'package:q_trip_user/domain/usecase/notification/get_notifications_usecase.dart';
import 'package:q_trip_user/domain/usecase/payment/get_promo_codes_usecase.dart';
import 'package:q_trip_user/domain/usecase/profile/get_profile_usecase.dart';
import 'package:q_trip_user/domain/usecase/profile/update_profile_image_usecase.dart';
import 'package:q_trip_user/domain/usecase/profile/update_profile_usecase.dart';
import 'package:q_trip_user/domain/usecase/profile/update_status_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/contact_us_request_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/get_about_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/get_categories_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/get_cities_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/get_country_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/get_privacy_usecase.dart';
import 'package:q_trip_user/domain/usecase/setting/get_terms_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/accept_trip_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/cancel_trip_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/get_distance_trip_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/get_my_offers_trip_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/get_trips_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/get_vehicles_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/report_trip_usecase.dart';
import 'package:q_trip_user/domain/usecase/trip/store_trip_usecase.dart';
import 'package:q_trip_user/domain/usecase/wallet/get_wallet_history_usecase.dart';
import 'package:q_trip_user/domain/usecase/wallet/recharge_wallet_usecase.dart';

import '../data/injection.dart';
import 'usecase/chat/get_message_list_usecase.dart';
import 'usecase/chat/send_message_usecase.dart';
import 'usecase/payment/check_promo_code_usecase.dart';
import 'usecase/trip/get_cancel_reasons_usecase.dart';
import 'usecase/trip/get_last_trip_usecase.dart';
import 'usecase/trip/get_my_live_driver_usecase.dart';
import 'usecase/trip/get_my_live_trip_usecase.dart';
import 'usecase/trip/rate_trip_usecase.dart';



Future<void> init() async {
  getIt.registerLazySingleton(() => GetSocialMediaUseCase(repository: getIt()));




  ///local
  getIt.registerLazySingleton(() => ClearUserDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => IsUserLoginUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetUserTokenUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => SaveUserDataUseCase(repository: getIt()));

  ///Auth
  getIt.registerLazySingleton(() => SignInUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ForgetPasswordUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => CheckOTPUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteAccountUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateFCMTokenUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => SendOtpUseCase(repository: getIt()));

  ///profile
  getIt.registerLazySingleton(() => GetProfileUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateProfileImageUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateStatusUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetCountriesUseCase(repository: getIt()));


  ///setting
  getIt.registerLazySingleton(() => GetCitiesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetCategoriesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ContactUsRequestUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetWalletHistoryUseCase(repository: getIt()));

  ///setting
  getIt.registerLazySingleton(() => GetTermsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetPrivacyUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetAboutUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetNotificationsUseCase(repository: getIt()));
  ///address
  getIt.registerLazySingleton(() => DeleteAddressUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => StoreAddressUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateAddressUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetAddressesUseCase(repository: getIt()));

  ///google places
  getIt.registerLazySingleton(() => GetPlacesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetDirectionUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetPlaceDetailsUseCase(repository: getIt()));

  ///trip
  getIt.registerLazySingleton(() => GetVehiclesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => StoreTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetMyLiveTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetMyLiveDriverUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => CancelTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetCancelReasonsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetLastTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => RateTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetTripsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ReportTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GeMyOffersTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => AcceptTripUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetDistanceTripUseCase(repository: getIt()));
  // getIt.registerLazySingleton(() => PaymentUseCase(repository: getIt()));

  ///chat
  getIt.registerLazySingleton(() => GetMessagesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => SendMessageUseCase(repository: getIt()));

  ///payment
  getIt.registerLazySingleton(() => GetPromoCodesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => CheckPromoCodeUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => RechargeWalletUseCase(repository: getIt()));


}