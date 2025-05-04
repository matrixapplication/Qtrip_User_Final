
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

import '../data/injection.dart';
import 'modules/address/search/store_search_address_cubit.dart';
import 'modules/address/store/store_address_cubit.dart';
import 'modules/chat/chat_cubit.dart';
import 'modules/home/home_cubit.dart';
import 'modules/promo/promo_cubit.dart';
import 'modules/search/search_cubit.dart';
import 'modules/select_car/select_car_cubit.dart';
import 'modules/trip/trip_cubit.dart';
import 'sheet/cancel_response_picker/cancel_response_picker_cubit.dart';
import 'sheet/rate_sheet/rate_cubit.dart';
//isOnTheWay

final List<dynamic> kDriverProviders =[
  BlocProvider(create: (_) => getIt<HomeCubit>()),
  BlocProvider(create: (_) => getIt<SearchCubit>()),
  BlocProvider(create: (_) => getIt<SelectCarCubit>()),
  BlocProvider(create: (_) => getIt<StoreSearchAddressCubit>()),
  BlocProvider(create: (_) => getIt<StoreAddressCubit>()),
  BlocProvider(create: (_) => getIt<CancelResponsePickerCubit>()),
  BlocProvider(create: (_) => getIt<TripCubit>()),
  BlocProvider(create: (_) => getIt<RateSheetCubit>()),
  BlocProvider(create: (_) => getIt<ChatCubit>()),
  BlocProvider(create: (_) => getIt<PromoCubit>()),

];


