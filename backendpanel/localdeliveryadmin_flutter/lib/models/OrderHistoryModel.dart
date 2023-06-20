class OrderHistoryModel {
  String? created_at;
  String? datetime;
  String? deleted_at;
  HistoryData? history_data;
  String? history_message;
  String? history_type;
  int? id;
  int? order_id;
  String? updated_at;

  OrderHistoryModel({
    this.created_at,
    this.datetime,
    this.deleted_at,
    this.history_data,
    this.history_message,
    this.history_type,
    this.id,
    this.order_id,
    this.updated_at,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      created_at: json['created_at'],
      datetime: json['datetime'],
      deleted_at: json['deleted_at'],
      history_data: json['history_data'] != null ? HistoryData.fromJson(json['history_data']) : null,
      history_message: json['history_message'],
      history_type: json['history_type'],
      id: json['id'],
      order_id: json['order_id'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['datetime'] = this.datetime;
    data['deleted_at'] = this.deleted_at;
    data['history_message'] = this.history_message;
    data['history_type'] = this.history_type;
    data['id'] = this.id;
    data['order_id'] = this.order_id;
    data['updated_at'] = this.updated_at;
    if (this.history_data != null) {
      data['history_data'] = this.history_data!.toJson();
    }
    return data;
  }
}

class HistoryData {
  String? client_id;
  String? client_name;

  HistoryData({
    this.client_id,
    this.client_name,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      client_id: json['client_id'],
      client_name: json['client_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.client_id;
    data['client_name'] = this.client_name;
    return data;
  }
}
