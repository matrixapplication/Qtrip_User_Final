class AppURL {
  static const String kAPIKey = "";
  ///Dev
  // static const String kBaseURL = "https://dev.qtrip-eg.com/api/";
  ///Live
  static const String kBaseURL = "https://qtrip-eg.com/api/";


  ///Auth
  static const String kLoginURI = "auth/login";
  static const String kRegisterURI = "auth/register";
  static const String kLogoutURI = "logout";
  static const String kSendOtpURI = "auth/otp";

  static const String kForgetPasswordURI = "auth/otp";
  static const String kCheckOTPURI = "auth/check-otp";
  static const String kChangePasswordURI = "profile/change_password";
  static const String kResetPasswordURI = "";
  static const String kDeleteAccountURI = "profile/delete-account";
  static const String kUpdateFCMTokenURI = "fcm_token";

  ///profile
  static const String kGetProfileURL = "profile";
  static const String kUpdateProfileStatusURL = "profile/change_status";
  static const String kUpdateProfileFilesURL = 'drivers/profile/files';

  static const String kUpdateProfileURL = "profile/update";
  static const String kUpdateProfileImageURL = "profile/uploadImage";

  ///setting
  static const String kGetCitiesURL = "";
  static const String kGetCategoriesURL = "";
  static const String kContactUsRequestURL = "send-contact-message";
  static const String kGetFAGsURL = "";
  static const String kGetCountriesURL = "get-countries";
  static const String kGetWalletHistoryURI = "wallet/history";
  static const String kRechargeWalletURI = "wallet/recharge";
  ///setting
  static const String kGetAboutURL = 'page/aboutUs';
  static const String kGetTermsURL = 'page/terms';
  static const String kGetPrivacyURL = 'page/privacy';


  ///address
  static const String kGetAddressesURL = "address";
  static const String kStoreAddressURL = "address/store";
  static const String kUpdateAddressURL = "address/update";
  static const String kDeleteAddressURL = "address/delete";

  ///vehicles
  static const String kGetVehiclesURL = "trips/vehicles/type";
  static const String kGetTripsURL = "trips";

  ///trips

  static const String kStoreTripURL = "trips/store";
  static const String kCancelTripURL = "trips/cancel";
  static const String kGetCancelReasonsURL = "trips/cancel-reasons";
  static const String kRateTripURL = "trips/rate/store";
  static const String kGetLastTripURL = "trips/last-trip";
  static const String kPaymentTripURL = "wallet/recharge";
  static const String kReportTripURL = "trips/report";
  static const String kAcceptTripURL = "trips/accept-trip";
  static const String kGetDestanceTripURL = "calculate_client_distance_time";

  ///PromoCode
  static const String kGetValidPromoCodeURL = "valid-promocode";
  static const String kCheckPromoCodeURL = "check-promocode";
  static const String kGetNotificationsURI = "get-notifications";
  static const String GetSocialMediasUrl = "social-media";

}
