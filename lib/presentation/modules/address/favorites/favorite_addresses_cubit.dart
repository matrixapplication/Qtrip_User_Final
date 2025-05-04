import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_addresses_state.dart';

class FavoriteAddressesCubit extends Cubit<FavoriteAddressesState> {
  FavoriteAddressesCubit() : super(FavoriteAddressesInitial());
}
