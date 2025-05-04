import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/animation/list_animator_data.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/custom_button.dart';
import '../../../component/no_data.dart';
import '../../../component/screen_state_layout.dart';
import '../../search/search_cubit.dart';
import '../../search/widgets/address_item.dart';

class FavoriteAddressesScreen extends StatefulWidget {

  const FavoriteAddressesScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteAddressesScreen> createState() => _FavoriteAddressesScreenState();
}

class _FavoriteAddressesScreenState extends State<FavoriteAddressesScreen> {

  @override
  Widget build(BuildContext context) {
    var addressesEntity = context.watch<SearchCubit>().addressesEntity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: tr(LocaleKeys.favoriteAddresses)),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> NavigationService.push(Routes.driverStoreSearchAddressScreen, arguments: {'addressTypes': AddressType.favorite}),
        child: Icon(Icons.add),
      ),
      body: ScreenStateLayout(
        isEmpty:(addressesEntity?.favorites??[]).isEmpty ,
        emptyBuilder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height: 500,
              child: NoDataScreen(title: tr(LocaleKeys.favoriteAddresses),desc: tr(LocaleKeys.saveTimeByAddingYourFavoritePlacesHear)),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [CustomButton(title: tr(LocaleKeys.addToFavorites),onTap: ()=>  NavigationService.push(Routes.driverStoreSearchAddressScreen, arguments: {'addressTypes': AddressType.favorite}),expanded: false)], )
          ],
        ),
        builder: (context) =>  ListAnimatorData(
          itemCount: addressesEntity?.favorites.length,
          scrollDirection:Axis.vertical ,
          itemBuilder: (context, index)=> AddressItem(  title: '', icon: Icons.location_history, onTap: () {  },)),
      ),
    );
  }
}
