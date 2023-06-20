import 'package:local_delivery_admin/models/PickupPointModel.dart';

class OrderModel {
  int? id;
  int? clientId;
  String? clientName;
  String? date;
  PickupPointModel? pickupPoint;
  PickupPointModel? deliveryPoint;
  int? countryId;
  String? countryName;
  int? cityId;
  String? cityName;
  String? parcelType;
  num? totalWeight;
  num? totalDistance;
  String? pickupDatetime;
  String? deliveryDatetime;
  int? parentOrderId;
  String? status;
  int? paymentId;
  String? paymentType;
  String? paymentStatus;
  String? paymentCollectFrom;
  int? deliveryManId;
  String? deliveryManName;
  num? fixedCharges;
  //List<ExtraChargeRequestModel>? extraCharges;
  var extraCharges;
  num? totalAmount;
  String? reason;
  int? pickupConfirmByClient;
  int? pickupConfirmByDeliveryMan;
  String? pickupTimeSignature;
  String? deliveryTimeSignature;
  String? deletedAt;
  bool? returnOrderId;
  num? distance_charge;
  num? weight_charge;

  OrderModel({
    this.id,
    this.clientId,
    this.clientName,
    this.date,
    this.pickupPoint,
    this.deliveryPoint,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.parcelType,
    this.totalWeight,
    this.totalDistance,
    this.pickupDatetime,
    this.deliveryDatetime,
    this.parentOrderId,
    this.status,
    this.paymentId,
    this.paymentType,
    this.paymentStatus,
    this.paymentCollectFrom,
    this.deliveryManId,
    this.deliveryManName,
    this.fixedCharges,
    this.extraCharges,
    this.totalAmount,
    this.reason,
    this.pickupConfirmByClient,
    this.pickupConfirmByDeliveryMan,
    this.pickupTimeSignature,
    this.deliveryTimeSignature,
    this.deletedAt,
    this.returnOrderId,
    this.distance_charge,
    this.weight_charge,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    date = json['date'];
    pickupPoint = json['pickup_point'] != null ? new PickupPointModel.fromJson(json['pickup_point']) : null;
    deliveryPoint = json['delivery_point'] != null ? new PickupPointModel.fromJson(json['delivery_point']) : null;
    countryId = json['country_id'];
    countryName = json['country_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    parcelType = json['parcel_type'];
    totalWeight = json['total_weight'];
    totalDistance = json['total_distance'];
    pickupDatetime = json['pickup_datetime'];
    deliveryDatetime = json['delivery_datetime'];
    parentOrderId = json['parent_order_id'];
    status = json['status'];
    paymentId = json['payment_id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    paymentCollectFrom = json['payment_collect_from'];
    deliveryManId = json['delivery_man_id'];
    deliveryManName = json['delivery_man_name'];
    fixedCharges = json['fixed_charges'];
   /* if (json['extra_charges'] != null) {
      extraCharges = <ExtraChargeRequestModel>[];
      json['extra_charges'].forEach((v) {
        extraCharges!.add(new ExtraChargeRequestModel.fromJson(v));
      });
    }*/
    extraCharges = json['extra_charges'];
    totalAmount = json['total_amount'];
    reason = json['reason'];
    pickupConfirmByClient = json['pickup_confirm_by_client'];
    pickupConfirmByDeliveryMan = json['pickup_confirm_by_delivery_man'];
    pickupTimeSignature = json['pickup_time_signature'];
    deliveryTimeSignature = json['delivery_time_signature'];
    deletedAt = json['deleted_at'];
    returnOrderId = json['return_order_id'];
    distance_charge = json['distance_charge'];
    weight_charge = json['weight_charge'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['date'] = this.date;
    if (this.pickupPoint != null) {
      data['pickup_point'] = this.pickupPoint!.toJson();
    }
    if (this.deliveryPoint != null) {
      data['delivery_point'] = this.deliveryPoint!.toJson();
    }
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['parcel_type'] = this.parcelType;
    data['total_weight'] = this.totalWeight;
    data['total_distance'] = this.totalDistance;
    data['pickup_datetime'] = this.pickupDatetime;
    data['delivery_datetime'] = this.deliveryDatetime;
    data['parent_order_id'] = this.parentOrderId;
    data['status'] = this.status;
    data['payment_id'] = this.paymentId;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['payment_collect_from'] = this.paymentCollectFrom;
    data['delivery_man_id'] = this.deliveryManId;
    data['delivery_man_name'] = this.deliveryManName;
    data['fixed_charges'] = this.fixedCharges;
    /*if (this.extraCharges != null) {
      data['extra_charges'] =
          this.extraCharges!.map((v) => v.toJson()).toList();
    }*/
    data['extra_charges'] = this.extraCharges;
    data['total_amount'] = this.totalAmount;
    data['reason'] = this.reason;
    data['pickup_confirm_by_client'] = this.pickupConfirmByClient;
    data['pickup_confirm_by_delivery_man'] = this.pickupConfirmByDeliveryMan;
    data['pickup_time_signature'] = this.pickupTimeSignature;
    data['delivery_time_signature'] = this.deliveryTimeSignature;
    data['deleted_at'] = this.deletedAt;
    data['return_order_id'] = this.returnOrderId;
    data['distance_charge'] = this.distance_charge;
    data['weight_charge'] = this.weight_charge;
    return data;
  }
}

class ExtraChargeRequestModel {
  String? key;
  num? value;
  String? valueType;

  ExtraChargeRequestModel({this.key, this.value,this.valueType});

  ExtraChargeRequestModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    valueType = json['value_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['value_type'] = this.valueType;
    return data;
  }
}
