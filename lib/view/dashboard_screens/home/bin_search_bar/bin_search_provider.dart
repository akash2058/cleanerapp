import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:flutter/material.dart';
enum SearchDataSource { binRequests, myOrders }

class SearchDataProvider with ChangeNotifier {
  int searchtab = 0;
void toggleTab(int index) {
    searchtab = index;
    notifyListeners();
  }

  List<RequestedItem> _allRequests = [];
  List<RequestedItem> _filteredRequests = [];

  List<RequestedItem> get filteredRequests => _filteredRequests;

  // Current source: bin requests or my orders
  SearchDataSource _currentSource = SearchDataSource.binRequests;
  SearchDataSource get currentSource => _currentSource;

  void updateData({
    required List<RequestedItem> binRequests,
    required List<RequestedItem> myOrders,
    required SearchDataSource source,
  }) {
    _currentSource = source;
    _allRequests = source == SearchDataSource.binRequests
        ? binRequests
        : myOrders;

    _filteredRequests = _allRequests;
    notifyListeners();
  }

  void filter(String query) {
    query = query.toLowerCase();
    _filteredRequests = _allRequests.where((item) {
      return item.location.toLowerCase().contains(query) == true ||
             item.binSizeName.toLowerCase().contains(query) == true;
    }).toList();
    notifyListeners();
  }
}
