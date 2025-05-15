import 'package:binbookingapp/view/dashboard_screens/bin_request/model/bin_booking_model.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/model/my_order_model.dart';
import 'package:flutter/material.dart';
enum SearchFilter { myOrders, binRequests }
enum RequestTab { dropoff, pickup }

class SearchDataProvider extends ChangeNotifier {
  SearchFilter selectedFilter = SearchFilter.myOrders;
  RequestTab selectedTab = RequestTab.dropoff;
  List<RequestedItem> binRequests = [];
  List<RequestsItem> myOrders = [];
  String searchQuery = '';

  void setFilter(SearchFilter filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void setTab(RequestTab tab) {
    selectedTab = tab;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    notifyListeners();
  }

  List<dynamic> get filteredList {
    if (selectedFilter == SearchFilter.myOrders) {
      if (selectedTab == RequestTab.dropoff) {
        return myOrders.where((item) =>
          _matchesQuery(item.location, item.binSizeName)).toList();
      } else {
        return myOrders.where((item) =>
          _matchesQuery(item.location, item.binSizeName)).toList();
      }
    } else {
      List<RequestedItem> base = selectedTab == RequestTab.dropoff
          ? binRequests.where((item) => item.type == 'Dropoff').toList()
          : binRequests.where((item) => item.type == 'Pickup').toList();

      return base.where((item) =>
        _matchesQuery(item.location, item.binSizeName)).toList();
    }
  }

  bool _matchesQuery(String? location, String? binSize) {
    return location?.toLowerCase().contains(searchQuery) == true ||
           binSize?.toLowerCase().contains(searchQuery) == true;
  }
}

