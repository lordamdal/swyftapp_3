import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:local_delivery_admin/main.dart';
import 'package:local_delivery_admin/models/CityListModel.dart';
import 'package:local_delivery_admin/utils/Common.dart';
import 'package:local_delivery_admin/utils/Constants.dart';
import 'package:local_delivery_admin/utils/Extensions/app_common.dart';

import '../network/RestApis.dart';
import '../utils/CommonApiCall.dart';

class CityInfoDialog extends StatefulWidget {
  static String tag = '/CityInfoDialog';

  final CityData? cityData;

  CityInfoDialog({this.cityData});

  @override
  CityInfoDialogState createState() => CityInfoDialogState();
}

class CityInfoDialogState extends State<CityInfoDialog> {
  String distanceType = '';
  String weightType = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await getDistanceAndWeightType();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  getDistanceAndWeightType() async {
    await getCountryDetail(widget.cityData!.countryId!).then((value) {
      distanceType = value.distanceType!;
      weightType = value.weightType!;
      setState(() { });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
      child: Container(
        width: 500,
        padding: EdgeInsets.all(16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.cityData!.name}', style: boldTextStyle(size: 20)),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            informationWidget(language.city_id, '${widget.cityData!.id}'),
            informationWidget(language.country_name, '${widget.cityData!.countryName}'),
            Divider(height: 20),
            informationWidget('${language.minimum_distance} ${distanceType.isNotEmpty ? '($distanceType)' : ''}', '${widget.cityData!.minDistance}'),
            informationWidget('${language.minimum_weight} ${weightType.isNotEmpty ? '($weightType)' : ''}', '${widget.cityData!.minWeight}'),
            Divider(height: 20),
            informationWidget(language.fixed_charge, '${widget.cityData!.fixedCharges}'),
            informationWidget(language.cancel_charge, '${widget.cityData!.cancelCharges}'),
            informationWidget(language.per_distance_charge, '${widget.cityData!.perDistanceCharges}'),
            informationWidget(language.per_weight_charge, '${widget.cityData!.perWeightCharges}'),
            Divider(height: 20),
            informationWidget(language.created_date, printDate(widget.cityData!.createdAt!)),
            informationWidget(language.updated_date, printDate(widget.cityData!.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
