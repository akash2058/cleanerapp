class MyOrderModel {
  final String? status;
  final String? message;
  final BinOrderData? data;

  MyOrderModel({this.status, this.message, this.data});

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? BinOrderData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class BinOrderData {
  final List<RequestsItem>? siteOrder;
  final List<RequestsItem>? warehouseOrder;

  BinOrderData({this.siteOrder, this.warehouseOrder});

  factory BinOrderData.fromJson(Map<String, dynamic> json) {
    return BinOrderData(
      siteOrder: (json['site_order'] as List<dynamic>?)
              ?.map((e) => RequestsItem.fromJson(e))
              .toList() ??
          [],
      warehouseOrder: (json['warehouse_order'] as List<dynamic>?)
              ?.map((e) => RequestsItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site_order': siteOrder?.map((e) => e.toJson()).toList(),
      'warehouse_order': warehouseOrder?.map((e) => e.toJson()).toList(),
    };
  }
}

class RequestsItem {
  final int? id;
  final int? quantity;
  final String? startDate;
  final String? endDate;
  final String? customerName;
  final String? location;
  final int? orderDuration;
  final String? binSizeName;
  final String? type;
  final String? stage;
  final String? status;
  final String? paymentOption;
  final String? paymentType;
  final String? pendingAmount;
  final String? paymentReceived;
  final int? remainingAmount;
  final int? requestOverdue;
  final int? orderOverdue;

  RequestsItem({
    this.id,
    this.quantity,
    this.startDate,
    this.endDate,
    this.customerName,
    this.location,
    this.orderDuration,
    this.binSizeName,
    this.type,
    this.stage,
    this.status,
    this.paymentOption,
    this.paymentType,
    this.pendingAmount,
    this.paymentReceived,
    this.remainingAmount,
    this.requestOverdue,
    this.orderOverdue,
  });

  factory RequestsItem.fromJson(Map<String, dynamic> json) {
    return RequestsItem(
      id: json['Id'],
      quantity: json['quantity'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      customerName: json['customer_name'],
      location: json['location'],
      orderDuration: json['order_duration'],
      binSizeName: json['bin_size_name'],
      type: json['type'],
      stage: json['stage'],
      status: json['status'],
      paymentOption: json['payment_option'],
      paymentType: json['payment_type'],
      pendingAmount: json['pending_amount']?.toString(),
      paymentReceived: json['payment_received']?.toString(),
      remainingAmount: json['remaining_amount'],
      requestOverdue: json['request_overdue'],
      orderOverdue: json['order_overdue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'quantity': quantity,
      'start_date': startDate,
      'end_date': endDate,
      'customer_name': customerName,
      'location': location,
      'order_duration': orderDuration,
      'bin_size_name': binSizeName,
      'type': type,
      'stage': stage,
      'status': status,
      'payment_option': paymentOption,
      'payment_type': paymentType,
      'pending_amount': pendingAmount,
      'payment_received': paymentReceived,
      'remaining_amount': remainingAmount,
      'request_overdue': requestOverdue,
      'order_overdue': orderOverdue,
    };
  }
}
