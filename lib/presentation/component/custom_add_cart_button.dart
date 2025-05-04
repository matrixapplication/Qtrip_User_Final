//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'custom_elevated_button.dart';
//
// class CustomAddCartButton extends StatelessWidget {
//   const CustomAddCartButton({super.key, required this.categoriesItemsModelData, required this.storeName, this.width, this.height, this.color, this.type, this.hasTotal});
//   final CategoryItemsData categoriesItemsModelData;
//   final String storeName;
//   final double? width;
//   final double? height;
//   final String? type;
//   final bool? hasTotal;
//   final Color? color;
//   @override
//   Widget build(BuildContext context) {
//     CartCubit cubit =CartCubit.get(context);
//     return BlocConsumer<CartCubit, CartState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var products =
//         cubit.products.where((CategoryItemsData element) => element.id == categoriesItemsModelData.id
//           //  type!='details'? (element.id == categoriesItemsModelData.id):(element.id == categoriesItemsModelData.id && element.itemExtraModelDataList==categoriesItemsModelData.itemExtraModelDataList)
//         );
//         if(type=='cart'){
//           var pCart =
//           cubit.products[cubit.products.indexOf(categoriesItemsModelData)];
//           // cubit.products.where((CategoryItemsData element) =>
//           // element.id == categoriesItemsModelData.id );
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       child: const CircleAvatar(
//                         backgroundColor: AppColors.backGroundPink2,
//                         radius: 13,
//                         child: Icon(Icons.remove,color: AppColors.backGroundPink3,weight: 5,size: 20,),
//                       ),
//                       onTap: (){
//                         cubit.removeQty(pCart,cubit.products.indexOf(pCart!));
//                       },
//                     ),
//                     SizedBox(width: 10.w,),
//                     CircleAvatar(
//                       backgroundColor: AppColors.sandwichBackGround,
//                       radius: 13,
//                       child: Text('${pCart.count}',
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 13
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10.w,),
//                     InkWell(
//                       child: const CircleAvatar(
//                         backgroundColor: AppColors.sandwichBackGround,
//                         radius: 13,
//                         child: Icon(Icons.add,color: AppColors.primaryColor,weight: 5,size: 20,),
//                       ),
//                       onTap: (){
//                         cubit.addQty(pCart,storeName);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               // CustomCheckButton(
//               //   width: width,
//               //   height:height?? 35.h,
//               //   categoriesItemsModelData:categoriesItemsModelData ,),
//
//             ],
//           );
//
//         }
//         else{
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               if (products.toList().length == 0)
//                 ...[
//                   if(hasTotal!=null&&hasTotal==true)
//                     Column(
//                       children: [
//                         BlackRegularText(label: '${LocaleKeys.totalPrice.tr()}',fontSize: 12.sp,),
//                         verticalSpace(5),
//                         BlackBoldText(label: '0.0 ${LocaleKeys.lyd.tr()}',fontSize: 20.sp,),
//                       ],
//                     ),
//                   Padding(
//                     padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
//                     child:
//                     Container(
//                       width: width,
//                       height: height??40.h,
//                       child:
//                       InkWell(
//                         onTap: (){
//                           if(cubit.products.isEmpty){
//                             categoriesItemsModelData.count=1;
//                             cubit.addProduct(product: categoriesItemsModelData, storeName: storeName);
//                           }else if(cubit.products[0].storeId == categoriesItemsModelData.storeId ){
//                             categoriesItemsModelData.count=1;
//                             cubit.addProduct(product: categoriesItemsModelData, storeName:storeName);
//                           }
//                           else{
//                             showToast(text: LocaleKeys.anotherCart.tr(), state: ToastStates.error, context: context);
//                           }
//                         },
//                         child: Container(
//                             padding: EdgeInsets.only(top: 0,right: 10,left: 10),
//                             decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 border: Border.all(color: AppColors.primaryColor),
//                                 borderRadius: BorderRadius.circular(50)),
//                             child:
//                             FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child:  Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   BlackBoldText(label: '${LocaleKeys.addCart.tr()}',fontSize: 12.sp,
//                                     labelColor: Colors.white,
//                                   ),
//                                   horizontalSpace(10),
//
//                                   Icon(Icons.add_shopping_cart_outlined,color: AppColors.whiteColor,weight: 5,size: 15,)
//                                 ],
//                               ),
//                             )
//                         ),
//                       ),
//
//                       // CustomElevatedButton(
//                       //     backgroundColor: color,
//                       //     borderRadius: 50,
//                       //     height: height,
//                       //     width: width,
//                       //     borderColor:color?? AppColors.primaryColor,
//                       //     fontColor: Colors.white,
//                       //     onTap: () {
//                       //       if(cubit.products.isEmpty){
//                       //         cubit.addProduct(product: categoriesItemsModelData, storeName: storeName);
//                       //       }
//                       //       if(cubit.products[0].storeId == categoriesItemsModelData.storeId ){
//                       //         cubit.addProduct(product: categoriesItemsModelData, storeName:storeName);
//                       //       }
//                       //       else{
//                       //         showToast(text: LocaleKeys.anotherCart.tr(), state: ToastStates.error, context: context);
//                       //       }
//                       //     },
//                       //     buttonText: LocaleKeys.addCart.tr()),
//                     ),
//                   ),
//                 ],
//               if (products.toList().length > 0)
//                 ...[
//                   if(hasTotal!=null&&hasTotal==true)
//                     Column(
//                       children: [
//                         BlackRegularText(label: '${LocaleKeys.totalPrice.tr()}',fontSize: 12.sp,),
//                         verticalSpace(5),
//                         BlackBoldText(label: '${cubit.getItemPrice(products.last).toStringAsFixed(1)} ${LocaleKeys.lyd.tr()}',fontSize: 20.sp,),
//                       ],
//                     ),
//                   Padding(
//                       padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
//                       child:
//                       FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child:    Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: (){
//                                 if(products.last.count! >0){
//                                   cubit.removeQty(products.last,cubit.products.indexOf(products.last));
//                                 }
//
//                               },
//                               child: Container(
//                                 height: 30.h,
//                                 width: 50.w,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.primaryColor,
//                                     border: Border.all(color: AppColors.primaryColor),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: Icon(Icons.remove,color: AppColors.whiteColor,weight: 5,size: 15,),
//                               ),
//                             ),
//
//                             SizedBox(width: 5.w,),
//                             Container(
//                                 height: 30.h,
//                                 width: 50.w,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.whiteColor,
//                                     border: Border.all(color: AppColors.primaryColor),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: Center(
//                                   child: Text('${products.last.count}',
//                                     style: const TextStyle(
//                                         color:AppColors.primaryColor,
//                                         fontSize: 13
//                                     ),
//                                   ),
//                                 )
//                             ),
//
//                             SizedBox(width: 5.w,),
//                             InkWell(
//                               onTap: (){
//                                 var x =
//                                 cubit.products.where((CategoryItemsData element) =>
//                                 (element.id == categoriesItemsModelData.id && element.itemExtraModelDataSelected==categoriesItemsModelData.itemExtraModelDataSelected)
//                                 );
//                                 if(x.length==0){
//                                   cubit.addProduct(product: categoriesItemsModelData, storeName: storeName);
//                                 }else{
//                                   cubit.addQty(products.last,storeName);
//                                 }
//
//                               },
//                               child: Container(
//                                 height: 30.h,
//                                 width: 50.w,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.primaryColor,
//                                     border: Border.all(color: AppColors.primaryColor),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: Icon(Icons.add,color: AppColors.whiteColor,weight: 5,size: 15,),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       )
//                   )
//                 ],
//               // CustomCheckButton(
//               //   width: width,
//               //   height:height?? 35.h,
//               //   categoriesItemsModelData:categoriesItemsModelData ,),
//
//             ],
//           );
//         }
//
//       },
//     );
//   }
// }
