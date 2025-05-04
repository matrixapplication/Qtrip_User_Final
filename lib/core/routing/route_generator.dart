import 'package:flutter/cupertino.dart';

import '../../presentation/modules/address/favorites/favorite_addresses_screen.dart';
import '../../presentation/modules/address/search/store_search_address_screen.dart';
import '../../presentation/modules/address/store/store_address_screen.dart';
import '../../presentation/modules/auth/congratulations/congratulations_screen.dart';
import '../../presentation/modules/auth/log_as/log_as_screen.dart';
import '../../presentation/modules/auth/login/login_screen.dart';
import '../../presentation/modules/auth/otp/otp_screen.dart';
import '../../presentation/modules/auth/register/register_screen.dart';
import '../../presentation/modules/chat/chat_screen.dart';
import '../../presentation/modules/delivery_profile/delivery_profile_screen.dart';
import '../../presentation/modules/home/home_screen.dart';
import '../../presentation/modules/my_trips/my_trips_screen.dart';
import '../../presentation/modules/promo/promo_screen.dart';
import '../../presentation/modules/search/search_screen.dart';
import '../../presentation/modules/select_car/select_car_screen.dart';
import '../../presentation/modules/setting/about_us/about_us_screen.dart';
import '../../presentation/modules/setting/change_password/change_password_screen.dart';
import '../../presentation/modules/setting/contact_us/contact_us_screen.dart';
import '../../presentation/modules/setting/notification/notifications_screen.dart';
import '../../presentation/modules/setting/payment/payment_screen.dart';
import '../../presentation/modules/setting/privacy_policy/privacy_policy_screen.dart';
import '../../presentation/modules/setting/profile/profile_screen.dart';
import '../../presentation/modules/setting/setting_screen.dart';
import '../../presentation/modules/setting/terms/terms_screen.dart';
import '../../presentation/modules/setting/wallet/wallet_screen.dart';
import '../../presentation/modules/trip/trip_screen.dart';
import '../../presentation/on_boarding/on_boarding_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import 'platform_page_route.dart';
import 'routes.dart';
import 'undefined_route_screen.dart';

class RouteGenerator {
  static Route generateBaseRoute(RouteSettings settings) {
    Map? arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case Routes.driverHomeScreen:return platformPageRoute(const DeliveryHomeScreen());
      case Routes.congratulationsScreen:return platformPageRoute(const CongratulationsScreen());
      case Routes.driverSearchScreen:return platformPageRoute(SearchScreen(addressBody: arguments?['addressBody']));
      case Routes.driverSelectCarScreen:return platformPageRoute(SelectCarScreen(fromLocationModel: arguments?['from'],toLocationModel: arguments?['to'],promoCodeEntity:arguments?['promo'],));
      case Routes.driverStoreSearchAddressScreen:return platformPageRoute(StoreSearchAddressScreen(addressEntity: arguments?['addressEntity'],addressTypes: arguments?['addressTypes']));
      case Routes.driverStoreAddressScreen:return platformPageRoute(StoreAddressScreen(addressBody: arguments?['addressBody']));
      case Routes.driverFavoriteAddressesScreen:return platformPageRoute(const FavoriteAddressesScreen());
      case Routes.onBoardingScreen:return platformPageRoute(const OnBoardingScreen());
      case Routes.logAsScreen:return platformPageRoute(const LogAsScreen());
      case Routes.registerScreen:return platformPageRoute(const RegisterScreen());
      case Routes.splashScreen:return platformPageRoute(const SplashScreen());
      case Routes.chatScreen:return platformPageRoute( ChatScreen(entity:  arguments?['entity']));

      case Routes.profileScreen:return platformPageRoute(const ProfileScreen());
      case Routes.changePasswordScreen:return platformPageRoute(const ChangePasswordScreen());
      case Routes.deliveryProfileScreen:return platformPageRoute( DeliveryProfileScreen(tripEntity: arguments?['tripEntity'],));
      case Routes.notificationsScreen:return platformPageRoute(const NotificationsScreen());
      case Routes.myTripsScreen:return platformPageRoute(const MyTripsScreen());
      case Routes.walletScreen:return platformPageRoute(const WalletScreen());
      case Routes.paymentScreen:return platformPageRoute(const PaymentScreen());
      case Routes.aboutUsScreen:return platformPageRoute(const AboutUsScreen());
      case Routes.contactUsScreen:return platformPageRoute(const ContactUsScreen());
      case Routes.privacyPolicyScreen:return platformPageRoute(const PrivacyPolicyScreen());
      case Routes.termsScreen:return platformPageRoute(const TermsScreen());
      case Routes.settingScreen:return platformPageRoute(const SettingScreen());
      case Routes.otpScreen:return platformPageRoute(OTPScreen(phone: arguments?['phone'],checkOTPType: arguments?['checkOTPType']));
      case Routes.loginScreen:return platformPageRoute(const LoginScreen());
      case Routes.driverTripScreen:return platformPageRoute( TripScreen(tripId:  arguments?['tripId']));
      case Routes.driverChatScreen:return platformPageRoute( ChatScreen(entity:  arguments?['entity']));
      case Routes.driverPromoScreen:return platformPageRoute( PromoScreen(promoCodeEntity:arguments?['promo']));
      default:return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}


