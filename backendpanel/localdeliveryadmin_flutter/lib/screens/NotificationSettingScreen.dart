import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:local_delivery_admin/main.dart';
import 'package:local_delivery_admin/models/NotificationSettingModel.dart';
import 'package:local_delivery_admin/network/RestApis.dart';
import 'package:local_delivery_admin/utils/Colors.dart';
import 'package:local_delivery_admin/utils/Common.dart';
import 'package:local_delivery_admin/utils/Constants.dart';
import 'package:local_delivery_admin/utils/DataProvider.dart';
import 'package:local_delivery_admin/utils/Extensions/app_common.dart';

class NotificationSettingScreen extends StatefulWidget {
  @override
  NotificationSettingScreenState createState() => NotificationSettingScreenState();
}

class NotificationSettingScreenState extends State<NotificationSettingScreen> {
  ScrollController notificationController = ScrollController();

  Map<String, dynamic> notificationSettings = {};

  @override
  void initState() {
    super.initState();
    afterBuildCreated(init);
  }

  void init() async {
    appStore.setLoading(true);
    await getSettingNotification(userID: shared_pref.getInt(USER_ID)!).then((value) {
      notificationSettings = value.notification_settings!.toJson();
      appStore.setLoading(false);
      setState(() {});
    }).catchError((error) {
      notificationSettings = getAppSetting();
      log("$error");
      setState(() {});
      appStore.setLoading(false);
    });
  }

  Future<void> saveNotification() async {
    appStore.setLoading(true);
    Map req = {
      "id": "${shared_pref.getInt(USER_ID)}",
      "notification_settings": NotificationSettings.fromJson(notificationSettings).toJson(),
    };
    await setNotification(req).then((value) {
      appStore.setLoading(false);
      toast(value.message);
    }).catchError((error) {
      appStore.setLoading(false);
      log(error);
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
        return Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: notificationController,
              padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 60),
              child: notificationSettings.isNotEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(language.notification, style: boldTextStyle(size: 22, color: primaryColor)),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(16),
                              decoration:
                                  BoxDecoration(color: appStore.isDarkMode ? scaffoldColorDark : Colors.white, borderRadius: BorderRadius.circular(defaultRadius), boxShadow: commonBoxShadow()),
                              child: DataTable(
                                headingTextStyle: boldTextStyle(size: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                ),
                                dataTextStyle: primaryTextStyle(),
                                headingRowColor: MaterialStateColor.resolveWith((states) => primaryColor.withOpacity(0.1)),
                                showCheckboxColumn: false,
                                dataRowHeight: 45,
                                headingRowHeight: 45,
                                horizontalMargin: 16,
                                columns: [
                                  DataColumn(label: Text(language.type)),
                                  DataColumn(label: Text(language.one_single)),
                                ],
                                rows: notificationSettings.entries.map((e) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(orderSettingStatus(e.key) ?? '', style: primaryTextStyle())),
                                      DataCell(
                                        Checkbox(
                                          value: e.value["IS_ONESIGNAL_NOTIFICATION"] == "1",
                                          onChanged: (val) {
                                            Notifications notify = Notifications.fromJson(notificationSettings[e.key]);
                                            if (val ?? false) {
                                              notify.iS_ONESIGNAL_NOTIFICATION = "1";
                                            } else {
                                              notify.iS_ONESIGNAL_NOTIFICATION = "0";
                                            }
                                            notificationSettings[e.key] = notify.toJson();
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              child: Text(language.save, style: boldTextStyle(color: Colors.white)),
                              onPressed: () async {
                                if (shared_pref.getString(USER_TYPE) == DEMO_ADMIN) {
                                  toast(language.demo_admin_msg);
                                } else {
                                  saveNotification();
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  : SizedBox(),
            ),
            appStore.isLoading
                ? loaderWidget()
                : notificationSettings.isEmpty
                    ? emptyWidget()
                    : SizedBox()
          ],
        );
      },
    );
  }
}
