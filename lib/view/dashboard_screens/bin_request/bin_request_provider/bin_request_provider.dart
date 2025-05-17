import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard/dashboard_view/dashboard_view.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/bin_request/service/bin_booking_api_service.dart';
import 'package:binbookingapp/view/shared_preference/binbooking_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BinRequestProvider extends ChangeNotifier {
  int currenttab = 0;
  bool loadingbinbooking = false;
  bool loadingrequestaccept = false;
  TextEditingController driveridcontroller = TextEditingController();
  TextEditingController bookingidcontroller = TextEditingController();
  BinBookingModel? _binBookingModel;
  BinBookingModel? get binbook => _binBookingModel;
  TextEditingController searchController = TextEditingController();

  Future<void> getBinRequestData() async {
    var token = await Utils.getToken(); // Await the token
    print('Token: $token'); // Now you’ll get the actual value

    try {
      loadingbinbooking = true;
      notifyListeners();

      final binbook = await fetchBinbooking(token ?? '');
      _binBookingModel = BinBookingModel.fromJson(binbook);

      print('bookkkkk: $binbook');
      loadingbinbooking = false;
      notifyListeners();
    } catch (e) {
      loadingbinbooking = false;
      notifyListeners();
      print('Error in binbookingdata $e');
      rethrow;
    }
  }

  void toggleTab(int index) {
    currenttab = index;
    notifyListeners();
  }

  Future<void> getRequestAccept(
    BuildContext context,
    String driverid,
    String bookingid,
  ) async {
    var token = await Utils.getToken(); // Await the token

    try {
      loadingrequestaccept = true;
      notifyListeners();

      final accept = await fetchRequestAccept(driverid, bookingid, token ?? '');

      loadingrequestaccept = false;
      notifyListeners();

      print('accept: $accept');

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardView()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height - 220.r,
              left: 10.r,
              right: 10.r,
            ),
            dismissDirection: DismissDirection.up,
            content: Text(
              accept['message'] ?? 'Unknown response',
              style: buttonfond,
            ),
            backgroundColor:
                accept['status'] == 'success'
                    ? CleanerAppcolors.primarydarkGreencolor
                    : CleanerAppcolors.primaryRedcolor,
          ),
        );
      }
    } catch (e) {
      loadingrequestaccept = false;
      notifyListeners();

      print('Error: $e');
      throw {"error": e};
    }
  }

  int searchtab = 0;
  String? currentFilterType;
  String? selectedType;

  List<RequestedItem> allRequests = [];
  List<RequestedItem> filteredRequests = [];

  void togglesearchtab(int index) {
    searchtab = index;
    notifyListeners();
  }

  void setRequests(
    List<RequestedItem> siteRequests,
    List<RequestedItem> warehouseRequests,
  ) {
    allRequests = [...siteRequests, ...warehouseRequests];
    filteredRequests = [];
    notifyListeners();
  }

  void setFilterType(String? type, {String query = ''}) {
    selectedType = type;
    filter(query);
  }

  void filter(String query) {
  query = query.toLowerCase().trim();

  // Always filter by type (selectedType), even if query is empty
  filteredRequests = allRequests.where((item) {
    final matchesType = selectedType == null
        ? true
        : item.type.toLowerCase() == selectedType?.toLowerCase();

    if (query.isEmpty) {
      return matchesType;
    } else {
      final matchesQuery =
          item.location.toLowerCase().contains(query) ||
          item.binSizeName.toLowerCase().contains(query);
      return matchesType && matchesQuery;
    }
  }).toList();

  notifyListeners();
}


  int get dropoffCount {
  final query = searchController.text.trim();
  if (query.isEmpty) return 0;

  return allRequests
      .where((item) => item.type.toLowerCase() == 'on_site_order')
      .where((item) =>
          item.location.toLowerCase().contains(query.toLowerCase()) ||
          item.binSizeName.toLowerCase().contains(query.toLowerCase()))
      .length;
}

int get pickupCount {
  final query = searchController.text.trim();
  if (query.isEmpty) return 0;

  return allRequests
      .where((item) => item.type.toLowerCase() == 'warehouse_dropoff')
      .where((item) =>
          item.location.toLowerCase().contains(query.toLowerCase()) ||
          item.binSizeName.toLowerCase().contains(query.toLowerCase()))
      .length;
}

}
