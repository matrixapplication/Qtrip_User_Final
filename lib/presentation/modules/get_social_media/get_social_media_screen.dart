import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/presentation/modules/get_social_media/get_social_media_cubit.dart';
import '../../component/screen_state_layout.dart';
import '../../component/social_media_widget.dart';
class GetSocialMediaWidget extends StatelessWidget {
  const GetSocialMediaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var socialCubit =context.read<GetSocialMediaCubit>();
    _getData (context, reload: true);
    return Center(
      child:  Center(
        child:  BlocBuilder<GetSocialMediaCubit, GetSocialMediaState>(
          buildWhen:(cubit, current) => (current is  GetSocialMediaSuccess ||current is GetSocialMediaLoading),
          builder: (context, state) => ScreenStateLayout(
            error:  null,
            isEmpty: (state is GetSocialMediaSuccess) ? (state.responseModel?.data?.data ?? []).isEmpty : false,
            isLoading: (state is GetSocialMediaLoading),
            onRetry: () => _getData(context, reload: true),
            builder: (context) {
              return SocialMediaWidget(list: socialCubit.socialMediaModel?.data??[],);
            }
          ),
        ),
      ),
    );
  }
  _getData(BuildContext context, {required bool reload}) =>
      BlocProvider.of<GetSocialMediaCubit>(context, listen: false).getSocialMediaLinks(reload: reload);

}
      