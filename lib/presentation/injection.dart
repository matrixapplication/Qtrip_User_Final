
import 'package:q_trip_user/presentation/sheet/rate_sheet/rate_cubit.dart';

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





Future<void> init() async {


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


}