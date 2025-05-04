part of 'store_address_cubit.dart';

@immutable
abstract class StoreAddressState {}

class StoreAddressInitial extends StoreAddressState {}

class StoreAddressLoading extends StoreAddressState {}
class UpdateAddressLoading extends StoreAddressState {}
class UpdateAddressSuccess extends StoreAddressState {}
