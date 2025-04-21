import 'dart:convert';

import 'package:binbookingapp/utils/apiurl.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> fetchBinbooking(String token) async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // ✅ Include the token!
    };

    var dio = Dio();

    var response = await dio.request(
      AppUrl.binbooking,
      options: Options(
        method: 'GET',
        headers: headers,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
print('response.data${response.data}');
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




Future<Map<String, dynamic>> fetchRequestAccept(
  String driverId,
  String binBookingId,
  String token,
) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Ensure token is valid and not expired
  };

  var data = jsonEncode({"driver_id": driverId, "booking_id": binBookingId});
  print(data);
  var dio = Dio();

  try {
    var response = await dio.request(
      AppUrl.acceptrequest,
      options: Options(
        method: 'POST',
        headers: headers,
        followRedirects: false, // <--- important: prevent redirect issues
        validateStatus: (status) => status != null && status < 500,
      ),
      data: data,
    );

    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');

    // If the response is already a Map, return directly
    if (response.data is Map<String, dynamic>) {
      return response.data;
    }

    // If response is not a Map, try decoding it
    try {
      return jsonDecode(response.data.toString());
    } catch (e) {
      return {"status": "error", "message": "Failed to parse response"};
    }
  } catch (e) {
    print('Error during request accept: $e');
    return {"status": "error", "message": "Something went wrong"};
  }
}
