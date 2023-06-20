import 'package:flutter/material.dart';
import 'package:local_delivery_admin/main.dart';
import 'package:local_delivery_admin/models/OrderDetailModel.dart';
import 'package:local_delivery_admin/models/OrderModel.dart';
import 'package:local_delivery_admin/network/RestApis.dart';
import 'package:local_delivery_admin/utils/Colors.dart';
import 'package:local_delivery_admin/utils/Common.dart';
import 'package:local_delivery_admin/utils/Constants.dart';
import 'package:local_delivery_admin/utils/Extensions/app_common.dart';

import '../components/BodyCornerWidget.dart';
import '../utils/Extensions/LiveStream.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  OrderDetailScreen({required this.orderId});

  @override
  OrderDetailScreenState createState() => OrderDetailScreenState();
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  num fixedCharges = 0;
  num minDistance = 0;
  num minWeight = 0;
  num perDistanceCharges = 0;
  num perWeightCharges = 0;
  List<ExtraChargeRequestModel> extraChargeForListType = [];
  Map<String, dynamic> extraChargeForObjectType = Map<String, dynamic>();
  bool extraChargeTypeIsList = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    LiveStream().on(streamLanguage, (p0) {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BodyCornerWidget(
      child: FutureBuilder<OrderDetailModel>(
        future: orderDetail(orderId: widget.orderId),
        builder: (_, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text('${snapShot.hasError.toString()}'),
            );
          }
          if (snapShot.hasData) {
            OrderModel? orderModel = snapShot.data!.data;
            extraChargeTypeIsList = orderModel!.extraCharges is List<dynamic>;
            if (extraChargeTypeIsList) {
              orderModel.extraCharges!.forEach((e) {
                ExtraChargeRequestModel element = ExtraChargeRequestModel.fromJson(e);
                if (element.key == FIXED_CHARGES) {
                  fixedCharges = element.value!;
                } else if (element.key == MIN_DISTANCE) {
                  minDistance = element.value!;
                } else if (element.key == MIN_WEIGHT) {
                  minWeight = element.value!;
                } else if (element.key == PER_DISTANCE_CHARGE) {
                  perDistanceCharges = element.value!;
                } else if (element.key == PER_WEIGHT_CHARGE) {
                  perWeightCharges = element.value!;
                } else {
                  extraChargeForListType.add(element);
                }
              });
            } else {
              fixedCharges = orderModel.fixedCharges!;
              extraChargeForObjectType = orderModel.extraCharges;
            }
            return Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 16, bottom: 60),
                    controller: ScrollController(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${language.order_id}', style: boldTextStyle()),
                              Text('#${orderModel.id.toString()}', style: boldTextStyle()),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(language.package_information, style: boldTextStyle(size: 22)),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(16),
                            decoration: containerDecoration(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(language.parcel_type, style: primaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ),
                                    Expanded(
                                      child: Text(orderModel.parcelType ?? '-', style: primaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.weight, style: primaryTextStyle()),
                                    Text('${orderModel.totalWeight.toString()} ${language.kg}', style: primaryTextStyle()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(language.payment_information, style: boldTextStyle(size: 22)),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(16),
                            decoration: containerDecoration(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.payment_type, style: primaryTextStyle()),
                                    Text(orderModel.paymentType ?? PAYMENT_TYPE_CASH, style: primaryTextStyle()),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.payment_collect_form, style: primaryTextStyle()),
                                    Text(orderModel.paymentCollectFrom ?? PAYMENT_ON_PICKUP, style: primaryTextStyle()),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.payment_status, style: primaryTextStyle()),
                                    Text(orderModel.paymentStatus ?? language.cod, style: primaryTextStyle()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          if (orderModel.deliveryPoint!.address != null)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(language.pickup_address, style: boldTextStyle(size: 22)),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  padding: EdgeInsets.all(16),
                                  decoration: containerDecoration(),
                                  child: Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.location_on, color: primaryColor),
                                          Text('...', style: boldTextStyle(size: 20, color: primaryColor)),
                                        ],
                                      ),
                                      SizedBox(height: 8, width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            orderModel.pickupDatetime != null ? Text('${language.picked_at} ${printDate(orderModel.pickupDatetime ?? '')}', style: secondaryTextStyle()) : SizedBox(),
                                            SizedBox(height: 8),
                                            Text(orderModel.pickupPoint!.address ?? '-', style: primaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 16),
                          if (orderModel.deliveryPoint!.address != null)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(language.delivery_address, style: boldTextStyle(size: 22)),
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 16),
                                  padding: EdgeInsets.all(16),
                                  decoration: containerDecoration(),
                                  child: Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('...', style: boldTextStyle(size: 20, color: primaryColor)),
                                          Icon(Icons.location_on, color: primaryColor),
                                        ],
                                      ),
                                      SizedBox(height: 8, width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            orderModel.deliveryDatetime != null ? Text('${language.delivered_at} ${printDate(orderModel.deliveryDatetime ?? '-')}', style: secondaryTextStyle()) : SizedBox(),
                                            SizedBox(height: 8),
                                            Text(orderModel.deliveryPoint!.address ?? '-', style: primaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(language.picUp_signature, style: boldTextStyle(size: 22)),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    padding: EdgeInsets.all(16),
                                    decoration: containerDecoration(),
                                    child: orderModel.pickupTimeSignature!.isNotEmpty
                                        ? commonCachedNetworkImage(
                                            orderModel.pickupTimeSignature ?? '-',
                                            fit: BoxFit.contain,
                                            height: 150,
                                            width: 150,
                                          )
                                        : Text(language.no_data),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(language.delivery_signature, style: boldTextStyle(size: 22)),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    padding: EdgeInsets.all(16),
                                    decoration: containerDecoration(),
                                    child: orderModel.deliveryTimeSignature!.isNotEmpty
                                        ? commonCachedNetworkImage(
                                            orderModel.deliveryTimeSignature!,
                                            fit: BoxFit.contain,
                                            height: 150,
                                            width: 150,
                                          )
                                        : Text(language.no_data),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16, bottom: 32),
                            padding: EdgeInsets.all(16),
                            decoration: containerDecoration(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.delivery_charges, style: primaryTextStyle()),
                                    SizedBox(width: 16),
                                    Text('$currencySymbol ${orderModel.fixedCharges}', style: primaryTextStyle()),
                                  ],
                                ),
                                if (orderModel.distance_charge != 0)
                                  Column(
                                    children: [
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(language.distance_charge, style: primaryTextStyle()),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text('(${(orderModel.totalDistance! - minDistance).toStringAsFixed(2)}', style: secondaryTextStyle()),
                                                Icon(Icons.close, color: Colors.grey, size: 12),
                                                Text('$perDistanceCharges)', style: secondaryTextStyle()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Text('$currencySymbol ${orderModel.distance_charge}', style: primaryTextStyle()),
                                        ],
                                      )
                                    ],
                                  ),
                                if (orderModel.weight_charge != 0)
                                  Column(
                                    children: [
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(language.weight_charge, style: primaryTextStyle()),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text('(${orderModel.totalWeight! - minWeight}', style: secondaryTextStyle()),
                                                Icon(Icons.close, color: Colors.grey, size: 12),
                                                Text('$perWeightCharges)', style: secondaryTextStyle()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Text('$currencySymbol ${orderModel.weight_charge}', style: primaryTextStyle()),
                                        ],
                                      ),
                                    ],
                                  ),
                                if ((orderModel.weight_charge != 0 || orderModel.distance_charge != 0) && (extraChargeForListType.length != 0 || extraChargeForObjectType.keys.length != 0))
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Text('$currencySymbol ${(orderModel.fixedCharges! + orderModel.distance_charge! + orderModel.weight_charge!).toStringAsFixed(2)}', style: primaryTextStyle()),
                                      ],
                                    ),
                                  ),
                                if (extraChargeForListType.length != 0 && extraChargeTypeIsList)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(language.extra_charges, style: boldTextStyle()),
                                      SizedBox(height: 8),
                                      Column(
                                          children: List.generate(extraChargeForListType.length, (index) {
                                        ExtraChargeRequestModel mData = extraChargeForListType.elementAt(index);
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              Text(mData.key!.replaceAll("_", " "), style: primaryTextStyle()),
                                              SizedBox(width: 4),
                                              Expanded(child: Text('(${mData.value}${mData.valueType == CHARGE_TYPE_PERCENTAGE ? '%' : "$currencySymbol"})', style: secondaryTextStyle())),
                                              SizedBox(width: 16),
                                              Text('$currencySymbol ${countExtraCharge(totalAmount: (fixedCharges + orderModel.weight_charge! + orderModel.distance_charge!), chargesType: mData.valueType!, charges: mData.value!)}',
                                                  style: primaryTextStyle()),
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                    ],
                                  ),
                                if (extraChargeForObjectType.keys.length != 0 && !extraChargeTypeIsList)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(language.extra_charges, style: boldTextStyle()),
                                      SizedBox(height: 8),
                                      Column(
                                        children: List.generate(orderModel.extraCharges.keys.length, (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(orderModel.extraCharges.keys.elementAt(index).replaceAll("_", " "), style: primaryTextStyle()),
                                                SizedBox(height: 8),
                                                Text('$currencySymbol ${orderModel.extraCharges.values.elementAt(index)}', style: primaryTextStyle()),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.total, style: boldTextStyle()),
                                    SizedBox(width: 16),
                                    Text('$currencySymbol ${orderModel.totalAmount}', style: boldTextStyle(size: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(top: 16, right: 16, child: backButton(context)),
              ],
            );
          }
          return loaderWidget();
        },
      ),
    );
  }
}
