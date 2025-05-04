import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../domain/request_body/address_body.dart';
import '../../../../domain/usecase/address/delete_address_usecase.dart';
import '../../../../domain/usecase/address/store_address_usecase.dart';
import '../../../../domain/usecase/address/update_address_usecase.dart';
import '../../search/search_cubit.dart';

part 'store_address_state.dart';

class StoreAddressCubit extends Cubit<StoreAddressState> {
  final StoreAddressUseCase _storeAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

   StoreAddressCubit({
    required StoreAddressUseCase storeAddressUseCase,
    required UpdateAddressUseCase updateAddressUseCase,
    required DeleteAddressUseCase deleteAddressUseCase,
  })  : _storeAddressUseCase = storeAddressUseCase,
        _updateAddressUseCase = updateAddressUseCase,
        _deleteAddressUseCase = deleteAddressUseCase,
         super(StoreAddressInitial());




   storeAddress({required AddressBody body,required String title})async{
      emit(StoreAddressLoading());
      ResponseModel responseModel =await _storeAddressUseCase.call(body: body.copyWith(title: title));
      emit(StoreAddressInitial());
      return responseModel;
   }

  updateAddress({required AddressBody body,required String title,required String id,required BuildContext context})async{
    emit(UpdateAddressLoading());
    ResponseModel responseModel =await _updateAddressUseCase.call(body: body.copyWith(title: title,id: id));
    BlocProvider.of<SearchCubit>(context, listen: false).getAddresses();
    emit(UpdateAddressSuccess());
    return responseModel;
  }

  deleteAddress({required int id,required BuildContext context})async{
    emit(UpdateAddressLoading());
    ResponseModel responseModel =await _deleteAddressUseCase.call(addressId:id);
    if(responseModel.isSuccess){
      BlocProvider.of<SearchCubit>(context, listen: false).getAddresses();
      Navigator.pop(context);
    }
    emit(UpdateAddressSuccess());
    return responseModel;
  }
}
