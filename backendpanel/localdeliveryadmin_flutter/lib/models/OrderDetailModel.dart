import 'package:local_delivery_admin/models/OrderModel.dart';

class OrderDetailModel {
  OrderModel? data;
  //List<OrderHistoryModel>? order_history;

  OrderDetailModel({this.data, /*this.order_history*/});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      data: json['data'] != null ? OrderModel.fromJson(json['data']) : null,
      //order_history: json['order_history'] != null ? (json['order_history'] as List).map((i) => OrderHistoryModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
   /* if (this.order_history != null) {
      data['order_history'] = this.order_history!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}
