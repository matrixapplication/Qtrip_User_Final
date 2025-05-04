

import 'package:q_trip_user/presentation/modules/get_social_media/get_social_media_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:q_trip_user/presentation/sheet/country_picker/country_picker_cubit.dart';
import 'package:q_trip_user/presentation/sheet/rate_sheet/rate_cubit.dart';
import 'package:q_trip_user/presentation/sheet/report_sheet/report_cubit.dart';

import 'data/injection.dart';
import 'domain/provider/local_auth_cubit.dart';
import 'presentation/sheet/cancel_response_picker/cancel_response_picker_cubit.dart';



class GenerateMultiBloc extends StatelessWidget {
  final Widget child;

  const GenerateMultiBloc({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///TODO add bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<GetSocialMediaCubit>()),



        BlocProvider(create: (_) => getIt<LocalAuthCubit>()),
        BlocProvider(create: (_) => getIt<LoginViewModel>()),
        BlocProvider(create: (_) => getIt<RegisterCubit>()),
        BlocProvider(create: (_) => getIt<OtpViewModelCubit>()),
        BlocProvider(create: (_) => getIt<CountryPickerCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<NotificationsCubit>()),
        BlocProvider(create: (_) => getIt<SelectCarCubit>()),
        BlocProvider(create: (_) => getIt<StoreSearchAddressCubit>()),
        BlocProvider(create: (_) => getIt<StoreAddressCubit>()),
        BlocProvider(create: (_) => getIt<CancelResponsePickerCubit>()),
        BlocProvider(create: (_) => getIt<ReportSheetCubit>()),
        BlocProvider(create: (_) => getIt<TripCubit>()),
        BlocProvider(create: (_) => getIt<RateSheetCubit>()),
        BlocProvider(create: (_) => getIt<ChatCubit>()),
        BlocProvider(create: (_) => getIt<PromoCubit>()),
        BlocProvider(create: (_) => getIt<ChangePasswordCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
        BlocProvider(create: (_) => getIt<TermsCubit>()),
        BlocProvider(create: (_) => getIt<PrivacyPolicyCubit>()),
        BlocProvider(create: (_) => getIt<ContactUsCubit>()),
        BlocProvider(create: (_) => getIt<WalletCubit>()),
        BlocProvider(create: (_) => getIt<AboutUsCubit>()),
        BlocProvider(create: (_) => getIt<MyTripsCubit>()),
      ],
      child: child,
    );

  }
}
