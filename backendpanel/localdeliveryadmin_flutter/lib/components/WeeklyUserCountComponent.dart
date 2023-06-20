import 'package:flutter/material.dart';
import 'package:local_delivery_admin/main.dart';
import 'package:local_delivery_admin/models/DashboardModel.dart';
import 'package:local_delivery_admin/utils/Colors.dart';
import 'package:local_delivery_admin/utils/Common.dart';
import 'package:local_delivery_admin/utils/Constants.dart';
import 'package:local_delivery_admin/utils/Extensions/app_common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyUserCountComponent extends StatefulWidget {
  static String tag = '/WeeklyUserCountComponent';
  final List<UserWeeklyModel> userWeeklyCount;

  WeeklyUserCountComponent({required this.userWeeklyCount});

  @override
  WeeklyUserCountComponentState createState() => WeeklyUserCountComponentState();
}

class WeeklyUserCountComponentState extends State<WeeklyUserCountComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 350,
      child: SfCartesianChart(
        title: ChartTitle(text: language.weekly_user_count, textStyle: boldTextStyle(color: primaryColor)),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          StackedColumnSeries<UserWeeklyModel, String>(
            color: primaryColor,
            enableTooltip: true,
            markerSettings: MarkerSettings(isVisible: true),
            dataSource: widget.userWeeklyCount,
            xValueMapper: (UserWeeklyModel exp, _) => exp.day,
            yValueMapper: (UserWeeklyModel exp, _) => exp.total,
          ),
        ],
        primaryXAxis: CategoryAxis(isVisible: true),
      ),
      decoration: BoxDecoration(
        boxShadow: commonBoxShadow(),
        color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    );
  }
}
