import '../../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  const WalletModel({
    required int id,
    required String message,
    required String data,
    required num amount,
  }) : super(id: id, message: message, amount: amount, data: data);

  factory WalletModel.fromJson(Map<String, dynamic>? json) => WalletModel(
      id: json?['id'] ?? -1,
      message: json?['message'] ?? '',
      data: json?['created_at'] ?? '',
      amount: json?['amount'] ?? 0);
}
