import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:local_delivery_admin/components/BodyCornerWidget.dart';
import 'package:local_delivery_admin/models/models.dart';
import 'package:local_delivery_admin/utils/Constants.dart';
import 'package:local_delivery_admin/utils/DataProvider.dart';
import 'package:local_delivery_admin/utils/Extensions/LiveStream.dart';

import '../main.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List<MenuItemModel> menuList = getMenuItems();
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    LiveStream().on(streamLanguage, (p0) {
      menuList.clear();
      menuList = getMenuItems();
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return BodyCornerWidget(
          isDashboard: true,
          child: menuList[appStore.selectedMenuIndex].widget,
        );
      }
    );
  }
}
