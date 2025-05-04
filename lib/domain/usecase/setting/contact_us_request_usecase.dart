import 'package:q_trip_user/core/utils/alerts.dart';
import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/data/model/base/response_model.dart';
import 'package:q_trip_user/domain/request_body/contact_us_request_body.dart';
import 'package:q_trip_user/domain/usecase/base_usecase/base_use_case_call.dart';
import 'package:q_trip_user/domain/usecase/base_usecase/base_usecase.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../repository/setting_repo.dart';

class ContactUsRequestUseCase implements BaseUseCase {
  final SettingRepository repository;

  ContactUsRequestUseCase({required this.repository});

  Future<ResponseModel> call({required ContactUsRequestsBody body}) async {
    return BaseUseCaseCall.onGetData(
        await repository.contactUsRequest(body), onConvert);
  }

  @override
  ResponseModel onConvert(BaseModel baseModel) {
    Alerts.showSnackBar(tr(LocaleKeys.theRequestHasBeenSentSuccessfully),alertsType: AlertsType.success);
    return ResponseModel(true, baseModel.message);
  }
}
