class BinBookingModel {
  final String status;
  final String message;
  final BinRequestData data;

  BinBookingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BinBookingModel.fromJson(Map<String, dynamic> json) {
    return BinBookingModel(
      status: json['status'],
      message: json['message'],
      data: BinRequestData.fromJson(json['data']),
    );
  }
}

class BinRequestData {
  final List<RequestedItem> siteRequests;
  final List<RequestedItem> warehouseRequests;

  BinRequestData({
    required this.siteRequests,
    required this.warehouseRequests,
  });

  factory BinRequestData.fromJson(Map<String, dynamic> json) {
    return BinRequestData(
      siteRequests: (json['site_requests'] as List<dynamic>?)
              ?.map((e) => RequestedItem.fromJson(e))
              .toList() ??
          [],
      warehouseRequests: (json['warehouse_requests'] as List<dynamic>?)
              ?.map((e) => RequestedItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class RequestedItem {
  final int id;
  final int quantity;
  final String startDate;
  final String endDate;
  final String customerName;
  final String customerContact;
  final String location;
  final int orderDuration;
  final String binSizeName;
  final String type;
  final String stage;
  final String status;
  final String? paymentOption;
  final String? paymentType;
  final String? pendingAmount;
  final String? paymentReceived;
  final String? remainingAmount;
  final int? requestOverdue;
  final int? orderOverdue;

  RequestedItem({
    required this.id,
    required this.quantity,
    required this.startDate,
    required this.endDate,
    required this.customerName,
    required this.customerContact,
    required this.location,
    required this.orderDuration,
    required this.binSizeName,
    required this.type,
    required this.stage,
    required this.status,
    this.paymentOption,
    this.paymentType,
    this.pendingAmount,
    this.paymentReceived,
    this.remainingAmount,
    this.requestOverdue,
    this.orderOverdue,
  });

  factory RequestedItem.fromJson(Map<String, dynamic> json) {
    return RequestedItem(
      id: json['Id'],
      quantity: json['quantity'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      customerName: json['customer_name'],
      customerContact: json['customer_contact'],
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
      remainingAmount: json['remaining_amount']?.toString(),
      requestOverdue: json['request_overdue'],
      orderOverdue: json['order_overdue'],
    );
  }
}
