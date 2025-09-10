class BinBookingModel {
  final String status;
  final String message;
  final BinRequestData? data;

  BinBookingModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory BinBookingModel.fromJson(Map<String, dynamic> json) {
    return BinBookingModel(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: json['data'] != null ? BinRequestData.fromJson(json['data']) : null,
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
  final int? id;
  final int? quantity;
  final String? startDate;
  final String? endDate;
  final String? customerName;
  final String? customerContact;
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
  final String? remainingAmount;
  final int? requestOverdue;
  final int? orderOverdue;
  final String? customerCompany;
  final String? comment;

  RequestedItem({
    this.id,
    this.quantity,
    this.startDate,
    this.endDate,
    this.customerName,
    this.customerContact,
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
    this.customerCompany,
    this.comment,
  });

  factory RequestedItem.fromJson(Map<String, dynamic> json) {
    return RequestedItem(
      id: _toInt(json['Id']),
      quantity: _toInt(json['quantity']),
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      customerName: json['customer_name']?.toString(),
      customerContact: json['customer_contact']?.toString(),
      location: json['location']?.toString(),
      orderDuration: _toInt(json['order_duration']),
      binSizeName: json['bin_size_name']?.toString(),
      type: json['type']?.toString(),
      stage: json['stage']?.toString(),
      status: json['status']?.toString(),
      paymentOption: json['payment_option']?.toString(),
      paymentType: json['payment_type']?.toString(),
      pendingAmount: json['pending_amount']?.toString(),
      paymentReceived: json['payment_received']?.toString(),
      remainingAmount: json['remaining_amount']?.toString(),
      requestOverdue: _toInt(json['request_overdue']),
      orderOverdue: _toInt(json['order_overdue']),
      customerCompany: json['customer_company']?.toString(),
      comment: json['comment']?.toString(),
    );
  }

  /// Helper: safely convert int or string to int?
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
