import 'dart:convert';

import 'package:binbookingapp/utils/apiurl.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> fetchMyorders(String token, String id) async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // ✅ Include the token!
    };

    var dio = Dio();

    var response = await dio.request(
      '${AppUrl.myorder}$id',
      options: Options(
        method: 'GET',
        headers: headers,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // print('Raw Response Data: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else if (response.data is String) {
      // If the response is not valid JSON (e.g. HTML), log and throw
      if (response.data.startsWith('<!DOCTYPE html>')) {
        throw Exception(
          "Received HTML page instead of JSON. Possible auth error.",
        );
      }
      return json.decode(response.data) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Unexpected response format: ${response.data.runtimeType}',
      );
    }
  } catch (error, stackTrace) {
    print('Error in fetchBinbooking: $error');
    print('Stack Trace: $stackTrace');
    throw Exception(
      'An error occurred while fetching bin booking data: $error',
    );
  }
}

Future<Map<String, dynamic>> fetchSerialData(
  String driverId,
  String binBookingId,
  List<String> serialNumber,
  String token,
) async {
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  var data = jsonEncode({
    "driver_id": driverId,
    "booking_id": binBookingId,
    "serial_numbers": serialNumber,
  });

  print('Request Data: $data');
  var dio = Dio();

  try {
    var response = await dio.request(
     '${ AppUrl.updateserialnumber}$binBookingId',
      options: Options(
        method: 'PUT',
        headers: headers,
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      data: data,
    );
    print(data);
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      return response.data;
    }

    try {
      return jsonDecode(response.data.toString());
    } catch (e) {
      return {"status": "error", "message": "Failed to parse response"};
    }
  } catch (e) {
    print('Error during request: $e');
    return {"status": "error", "message": "Something went wrong"};
  }
}

Future<Map<String, dynamic>> fetchUpdateAttachments(
  String driverId,
  String binBookingId,
  Map<String, dynamic> attachments,  // Change to accept a map
  String token,
) async {
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  var data = jsonEncode({
    "driver_id": driverId,
    "booking_id": binBookingId,
    "booking_attachments": attachments,  // Attach the map directly
  });

  print('Request Data: $data');
  var dio = Dio();

  try {
    var response = await dio.request(
      '${AppUrl.updateattachments}$binBookingId',
      options: Options(
        method: 'PUT',
        headers: headers,
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      data: data,
    );
    print(data);
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      return response.data;
    }

    try {
      return jsonDecode(response.data.toString());
    } catch (e) {
      return {"status": "error", "message": "Failed to parse response"};
    }
  } catch (e) {
    print('Error during request: $e');
    return {"status": "error", "message": "Something went wrong"};
  }
}

Future<Map<String, dynamic>> fetchmyordersdropoff(String token, String id) async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // ✅ Include the token!
    };

    var dio = Dio();

    var response = await dio.request(
      '${AppUrl.binbookingdetails}$id',
      options: Options(
        method: 'GET',
        headers: headers,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // print('Raw Response Data: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else if (response.data is String) {
      // If the response is not valid JSON (e.g. HTML), log and throw
      if (response.data.startsWith('<!DOCTYPE html>')) {
        throw Exception(
          "Received HTML page instead of JSON. Possible auth error.",
        );
      }
      return json.decode(response.data) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Unexpected response format: ${response.data.runtimeType}',
      );
    }
  } catch (error, stackTrace) {
    print('Error in fetchBinbooking: $error');
    print('Stack Trace: $stackTrace');
    throw Exception(
      'An error occurred while fetching bin booking data: $error',
    );
  }
}
