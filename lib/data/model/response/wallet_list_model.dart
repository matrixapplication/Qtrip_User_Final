
import 'package:q_trip_user/data/model/response/wallet_model.dart';

import '../../../domain/entities/wallet_list_entity.dart';

class WalletListModel extends WalletListEntity {
  const WalletListModel({
    required int currentPage,
    required int lastPage,
    required int amount,
    required List<WalletModel> list,
  }) : super(currentPage: currentPage, lastPage: lastPage, list: list, amount: amount);

  factory WalletListModel.fromJson(Map<String, dynamic>? json) =>
      WalletListModel(
        currentPage: json?['data']['current_page'] ?? 1,
        lastPage: json?['data']['last_page'] ?? 0,
        amount: json?['total'] ?? 0,
        list: List<WalletModel>.from((json?['data']["data"]??[]).map((x) => WalletModel.fromJson(x))),

  );


}
