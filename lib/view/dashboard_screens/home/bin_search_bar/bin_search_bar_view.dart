import 'package:binbookingapp/view/dashboard_screens/home/bin_search_bar/bin_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BinSearchScreen extends StatelessWidget {
  const BinSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchDataProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(hintText: 'Search by location or bin size'),
            onChanged: provider.setSearchQuery,
          ),
          actions: [
            PopupMenuButton<SearchFilter>(
              onSelected: provider.setFilter,
              itemBuilder: (_) => [
                PopupMenuItem(value: SearchFilter.myOrders, child: Text('My Orders')),
                PopupMenuItem(value: SearchFilter.binRequests, child: Text('Bin Requests')),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [Tab(text: 'Dropoff'), Tab(text: 'Pickup')],
            onTap: (index) => provider.setTab(index == 0 ? RequestTab.dropoff : RequestTab.pickup),
          ),
        ),
        body: ListView.builder(
          itemCount: provider.filteredList.length,
          itemBuilder: (context, index) {
            final item = provider.filteredList[index];
            return ListTile(
              title: Text(item.location ?? 'Unknown Location'),
              subtitle: Text(item.binSizeName ?? 'Unknown Bin Size'),
            );
          },
        ),
      ),
    );
  }
}
