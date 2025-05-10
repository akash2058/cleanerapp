class MyOrderModel {
  final String status;
  final String message;
  final BinOrderData data;

  MyOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
      status: json['status'],
      message: json['message'],
      data: BinOrderData.fromJson(json['data']),
    );
  }
}

class BinOrderData {
  final List<RequestsItem> siteOrder;
  final List<RequestsItem> warehouseOrder;

  BinOrderData({
    required this.siteOrder,
    required this.warehouseOrder,
  });

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
}

class RequestsItem {
  final int id;
  final int quantity;
  final String startDate;
  final String endDate;
  final String customerName;
  final String location;
  final int orderDuration;
  final String binSizeName;
  final String type;
  final String stage;
  final String status;
  final String paymentOption;
  final String? paymentType;
  final String? pendingAmount;
  final String paymentReceived;
  final int? remainingAmount;

  RequestsItem({
    required this.id,
    required this.quantity,
    required this.startDate,
    required this.endDate,
    required this.customerName,
    required this.location,
    required this.orderDuration,
    required this.binSizeName,
    required this.type,
    required this.stage,
    required this.status,
    required this.paymentOption,
    this.paymentType,
    this.pendingAmount,
    required this.paymentReceived,
    this.remainingAmount,
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
      paymentOption: json['payment_option'] ?? '',
      paymentType: json['payment_type'],
      pendingAmount: json['pending_amount'],
      paymentReceived: json['payment_received'] ?? '0',
      remainingAmount: json['remaining_amount'],
    );
  }
}
