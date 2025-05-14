import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:flutter/material.dart';
enum SearchDataSource { binRequests, myOrders }

class SearchDataProvider with ChangeNotifier {
  int searchtab = 0;

  void toggleTab(int index) {
    searchtab = index;
    _applyFilter(); // Reapply filter when tab changes
  }

  List<RequestedItem> _allRequests = [];
  List<RequestedItem> _filteredRequests = [];

  List<RequestedItem> get filteredRequests => _filteredRequests;

  SearchDataSource _currentSource = SearchDataSource.binRequests;
  SearchDataSource get currentSource => _currentSource;

  String _currentQuery = "";

  void updateData({
    required List<RequestedItem> binRequests,
    required List<RequestedItem> myOrders,
    required SearchDataSource source,
  }) {
    _currentSource = source;
    _allRequests = source == SearchDataSource.binRequests ? binRequests : myOrders;
    _applyFilter();
  }

  void filter(String query) {
    _currentQuery = query.toLowerCase();
    _applyFilter();
  }

  void _applyFilter() {
    _filteredRequests = _allRequests.where((item) {
      final matchesQuery = item.location.toLowerCase().contains(_currentQuery) ||
                           item.binSizeName.toLowerCase().contains(_currentQuery);
      final matchesTab = searchtab == 0
          ? item.type.toLowerCase() == 'dropoff'
          : item.type.toLowerCase() == 'pickup';
      return matchesQuery && matchesTab;
    }).toList();
    notifyListeners();
  }
}

