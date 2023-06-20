import 'package:flutter/material.dart';
import 'package:local_delivery_admin/components/HomeWidgetUserList.dart';
import 'package:local_delivery_admin/models/DashboardModel.dart';
import 'package:local_delivery_admin/network/RestApis.dart';
import 'package:local_delivery_admin/utils/Colors.dart';
import 'package:local_delivery_admin/utils/Common.dart';
import 'package:local_delivery_admin/utils/Constants.dart';
import 'package:local_delivery_admin/utils/Extensions/LiveStream.dart';
import 'package:local_delivery_admin/utils/Extensions/app_common.dart';

import '../main.dart';
import 'WeeklyOrderCountComponent.dart';
import 'WeeklyUserCountComponent.dart';

class HomeWidget extends StatefulWidget {
  static String tag = '/HomeComponent';

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  ScrollController scrollController = ScrollController();
  ScrollController recentOrderController = ScrollController();
  ScrollController recentOrderHorizontalController = ScrollController();
  ScrollController upcomingOrderController = ScrollController();
  ScrollController upcomingOrderHorizontalController = ScrollController();
  ScrollController userController = ScrollController();
  ScrollController userHorizontalController = ScrollController();
  ScrollController deliveryBoyController = ScrollController();
  ScrollController deliveryBoyHorizontalController = ScrollController();

  List<UserWeeklyModel> userWeeklyCount = [];
  List<WeeklyOrderModel> weeklyOrderCount = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    LiveStream().on(streamDarkMode, (p0) {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void callMethod(int count) {
    afterBuildCreated(() => appStore.setAllUnreadCount(count));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardModel>(
      future: getDashBoardData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userWeeklyCount = snapshot.data!.user_weekly_count!;
          weeklyOrderCount = snapshot.data!.weekly_order_count!;
          callMethod(snapshot.data!.all_unread_count ?? 0);
          return SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    totalUserWidget(title: language.total_user, totalCount: snapshot.data!.total_client, image: 'assets/icons/ic_users.png'),
                    totalUserWidget(title: language.total_delivery_person, totalCount: snapshot.data!.total_delivery_man, image: 'assets/icons/ic_users.png'),
                    totalUserWidget(title: language.total_country, totalCount: snapshot.data!.total_country, image: 'assets/icons/ic_country.png'),
                    totalUserWidget(title: language.total_city, totalCount: snapshot.data!.total_city, image: 'assets/icons/ic_city.png'),
                    totalUserWidget(title: language.total_order, totalCount: snapshot.data!.total_order, image: 'assets/icons/ic_orders.png'),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: WeeklyOrderCountComponent(weeklyOrderCount: weeklyOrderCount)),
                    SizedBox(width: 16),
                    Expanded(child: WeeklyUserCountComponent(userWeeklyCount: userWeeklyCount)),
                  ],
                ),
                SizedBox(height: 16),
                Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: [
                    if (snapshot.data!.recent_order!.isNotEmpty)
                      Container(
                        height: 500,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        width: (getBodyWidth(context) - 48) * 0.5,
                        child: SingleChildScrollView(
                          controller: recentOrderHorizontalController,
                          padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(language.recent_order, style: boldTextStyle(color: primaryColor)),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                controller: recentOrderController,
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingTextStyle: boldTextStyle(),
                                  dataTextStyle: primaryTextStyle(size: 15),
                                  headingRowColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.1)),
                                  showCheckboxColumn: false,
                                  dataRowHeight: 45,
                                  headingRowHeight: 45,
                                  horizontalMargin: 16,
                                  columns: [
                                    DataColumn(label: Text(language.order_id)),
                                    DataColumn(label: Text(language.customer_name)),
                                    DataColumn(label: Text(language.delivery_person)),
                                    DataColumn(label: Text(language.pickup_date)),
                                    DataColumn(label: Text(language.created_date)),
                                    DataColumn(label: Text(language.status)),
                                  ],
                                  rows: snapshot.data!.recent_order!.map((e) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text('${e.id}')),
                                        DataCell(Text(e.clientName ?? "-")),
                                        DataCell(Text(e.deliveryManName ?? "-")),
                                        DataCell(Text(e.pickupDatetime != null ? printDate(e.pickupDatetime ?? '-') : '-')),
                                        DataCell(Text(printDate(e.date ?? '-'))),
                                        DataCell(
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text(orderStatus(e.status!) ?? '-', style: boldTextStyle(color: statusColor(e.status ?? ""), size: 15)),
                                            decoration: BoxDecoration(color: statusColor(e.status ?? "").withOpacity(0.15), borderRadius: BorderRadius.circular(defaultRadius)),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: commonBoxShadow(),
                          color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                      )
                    else
                      SizedBox(),
                    snapshot.data!.upcoming_order!.isNotEmpty
                        ? Container(
                            height: 500,
                            padding: EdgeInsets.only(left: 8, right: 8),
                            width: (getBodyWidth(context) - 48) * 0.5,
                            child: SingleChildScrollView(
                              controller: upcomingOrderController,
                              padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(language.upcoming_order, style: boldTextStyle(color: primaryColor)),
                                  SizedBox(height: 20),
                                  SingleChildScrollView(
                                    controller: upcomingOrderHorizontalController,
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      headingTextStyle: boldTextStyle(),
                                      dataTextStyle: primaryTextStyle(size: 15),
                                      headingRowColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.1)),
                                      showCheckboxColumn: false,
                                      dataRowHeight: 45,
                                      headingRowHeight: 45,
                                      horizontalMargin: 16,
                                      columns: [
                                        DataColumn(label: Text(language.order_id)),
                                        DataColumn(label: Text(language.customer_name)),
                                        DataColumn(label: Text(language.delivery_person)),
                                        DataColumn(label: Text(language.pickup_date)),
                                        DataColumn(label: Text(language.created_date)),
                                        DataColumn(label: Text(language.status)),
                                      ],
                                      rows: snapshot.data!.upcoming_order!.map((e) {
                                        return DataRow(
                                          cells: [
                                            DataCell(Text('${e.id}')),
                                            DataCell(Text(e.clientName ?? "-")),
                                            DataCell(Text(e.deliveryManName ?? "-")),
                                            DataCell(Text(e.pickupDatetime != null ? printDate(e.pickupDatetime ?? '-') : '-')),
                                            DataCell(Text(printDate(e.date ?? '-'))),
                                            DataCell(
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                child: Text(orderStatus(e.status!) ?? '-', style: boldTextStyle(color: statusColor(e.status ?? ""), size: 15)),
                                                decoration: BoxDecoration(color: statusColor(e.status ?? "").withOpacity(0.15), borderRadius: BorderRadius.circular(defaultRadius)),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: commonBoxShadow(),
                              color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          )
                        : SizedBox(),
                    snapshot.data!.recent_client!.isNotEmpty
                        ? Container(
                            height: 500,
                            padding: EdgeInsets.only(left: 8, right: 8),
                            width: (getBodyWidth(context) - 48) * 0.5,
                            child: SingleChildScrollView(
                              controller: userController,
                              padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(language.recent_user, style: boldTextStyle(color: primaryColor)),
                                      TextButton(
                                        onPressed: () {
                                          appStore.setSelectedMenuIndex(USER_INDEX);
                                        },
                                        child: Text(language.view_all, style: boldTextStyle(color: primaryColor)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SingleChildScrollView(
                                    controller: userHorizontalController,
                                    scrollDirection: Axis.horizontal,
                                    child: HomeWidgetUserList(userModel: snapshot.data!.recent_client!),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: commonBoxShadow(),
                              color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          )
                        : SizedBox(),
                    snapshot.data!.recent_delivery_man!.isNotEmpty
                        ? Container(
                            height: 500,
                            padding: EdgeInsets.only(left: 8, right: 8),
                            width: (getBodyWidth(context) - 48) * 0.5,
                            child: SingleChildScrollView(
                              controller: deliveryBoyController,
                              padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(language.recent_delivery, style: boldTextStyle(color: primaryColor)),
                                      TextButton(
                                        onPressed: () {
                                          appStore.setSelectedMenuIndex(DELIVERY_PERSON_INDEX);
                                        },
                                        child: Text(language.view_all, style: boldTextStyle(color: primaryColor)),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SingleChildScrollView(
                                    controller: deliveryBoyHorizontalController,
                                    scrollDirection: Axis.horizontal,
                                    child: HomeWidgetUserList(userModel: snapshot.data!.recent_delivery_man!),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: commonBoxShadow(),
                              color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
                              borderRadius: BorderRadius.circular(defaultRadius),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(height: 80)
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.hasError.toString()}'),
          );
        }
        return loaderWidget();
      },
    );
  }
}
