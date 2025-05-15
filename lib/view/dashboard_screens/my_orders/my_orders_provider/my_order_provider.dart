import 'dart:convert' show base64Encode;
import 'dart:io';

import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:binbookingapp/view/dashboard/dashboard_view/dashboard_view.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/model/my_order_dropoff_details_model.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/model/my_order_model.dart';
import 'package:binbookingapp/view/dashboard_screens/my_orders/service/my_order_api_service.dart';
import 'package:binbookingapp/view/shared_preference/binbooking_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class MyOrderProvider extends ChangeNotifier {
  bool isdamaged = true;

  bool loadingserialdata = false;
  bool loadingmyorderdropoffdetail = false;
  bool loadingmyorderdata = false;
  bool loadingattachments = false;
  bool loadingupdatewarehouse = false;
  bool loadingconfirmonsitepickup = false;
  bool loadingbookingdamage = false;

  MyOrderModel? _myOrderModel;
  MyOrderModel? get order => _myOrderModel;
  MyOrdersDropOffDetailModel? _myOrdersDropOffDetailModel;
  MyOrdersDropOffDetailModel? get orderdetail => _myOrdersDropOffDetailModel;
  int tabs = 0;

  TextEditingController amountreceivecontroller = TextEditingController();
  TextEditingController paymentreceivecontroller = TextEditingController();
  void toggleTab(int index) {
    tabs = index;
    notifyListeners();
  }

  Future<void> getMyordersData(id) async {
    var token = await Utils.getToken(); // Await the token
    try {
      loadingmyorderdata = true;
      notifyListeners();
      final binbook = await fetchMyorders(token ?? '', id);
      _myOrderModel = MyOrderModel.fromJson(binbook);
      print('myorderdetails $binbook');

      loadingmyorderdata = false;
      notifyListeners();
    } catch (e) {
      loadingmyorderdata = false;
      notifyListeners();
      print('Error in getWalletData: $e');
      rethrow;
    }
  }

  Future<void> getMyorderDropOffDetail(String id) async {
    var token = await Utils.getToken();
    try {
      loadingmyorderdropoffdetail = true;
      notifyListeners();

      final binbook = await fetchmyordersdropoff(token ?? '', id);
      _myOrdersDropOffDetailModel = MyOrdersDropOffDetailModel.fromJson(
        binbook,
      );

      // ✅ Initialize isDamagedList and imagesPerBin here
      final count =
          _myOrdersDropOffDetailModel?.bookingSerialNumbers?.length ?? 0;
      initializeDamagedList(count);

      print('myorder $binbook');

      loadingmyorderdropoffdetail = false;
      notifyListeners();
    } catch (e) {
      loadingmyorderdata = false;
      notifyListeners();
      print('Error in getfetchdetailsdata: $e');
      rethrow;
    }
  }

  List<TextEditingController> serialControllers = [];
  List<String> binSerialNumbers = [];

  Future<void> getSerialData(
    BuildContext context,
    String bookingid,
    String driverid,
  ) async {
    final navigator = Navigator.of(context); // Save before any await
    final messenger = ScaffoldMessenger.of(context); // Save before any await
    final screenSize = MediaQuery.sizeOf(context);

    var token = await Utils.getToken();
    print('Booking ID: $bookingid, Driver ID: $driverid');

    try {
      loadingserialdata = true;
      notifyListeners();

      // Extract serial numbers
      List<String> serialNumbers =
          serialControllers
              .map((controller) => controller.text.trim())
              .toList();

      final accept = await fetchSerialData(
        driverid,
        bookingid,
        serialNumbers,
        token ?? '',
      );

      loadingserialdata = false;
      notifyListeners();

      // ✅ Safe to use saved messenger
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: screenSize.height - 170.r,
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

      // ✅ Navigate only if successful
      if (accept['status'] == 'success') {
        navigator.push(CustomPageRoute(child: DashboardView()));
      }
    } catch (e) {
      loadingserialdata = false;
      notifyListeners();

      // ✅ Safe error toast
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );

      print('Error: $e');
    }
  }

  Future<void> getConfirmonsiteupdate(
    BuildContext context,
    String driverid,
    String bookingid,
  ) async {
    final navigator = Navigator.of(context); // Save before any await //
    final messenger = ScaffoldMessenger.of(context); // cache before await
    final screenSize = MediaQuery.sizeOf(context);
    var token = await Utils.getToken();
  final amountText = amountreceivecontroller.text.trim();
    final amountToSend = amountText.isEmpty ? '0' : amountText;
    try {
      loadingconfirmonsitepickup = true;
      notifyListeners();

      final accept = await fetchConfirmonsiteupdate(
        driverid,
        bookingid,
        token ?? '',
        amountToSend
      );
      print('✅ API Response: $accept');

      final status = accept['status'];
      final message = accept['message'] ?? 'No message';

      // ✅ Show snackbar using cached messenger
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: screenSize.height - 170.r,
            left: 10.r,
            right: 10.r,
          ),
          dismissDirection: DismissDirection.up,

          content: Text(message, style: buttonfond),
          backgroundColor:
              status == 'success'
                  ? CleanerAppcolors.primarydarkGreencolor
                  : CleanerAppcolors.primaryRedcolor,
        ),
      );
      if (accept['status'] == 'success') {
        navigator.push(
          MaterialPageRoute(builder: (context) => DashboardView()),
        );
      }
      loadingconfirmonsitepickup = false;
      notifyListeners();
    } catch (e) {
      loadingconfirmonsitepickup = false;
      notifyListeners();

      // ✅ Still using cached messenger
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: -220.r, left: 10.r, right: 10.r),
          dismissDirection: DismissDirection.up,
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );

      throw {"error": e};
    }
  }

  Future<void> getConfirmwarehouseupdate(
    BuildContext context,
    String driverid,
    String bookingid,
  ) async {
    final messenger = ScaffoldMessenger.of(
      context,
    ); // ✅ Cache this before await
    final screenSize = MediaQuery.sizeOf(
      context,
    ); // ✅ Cache mediaQuery before await
    final navigator = Navigator.of(context);
    var token = await Utils.getToken();

    try {
      loadingupdatewarehouse = true;
      notifyListeners();

      final accept = await fetchConfirmWarehouseupdate(
        driverid,
        bookingid,
        token ?? '',
      );

      loadingupdatewarehouse = false;
      notifyListeners();

      final status = accept['status'];
      final message = accept['message'] ?? 'No message';
      print('confirm: $accept');

      // ✅ Use cached messenger and screenSize
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: screenSize.height - 170.r,
            left: 10.r,
            right: 10.r,
          ),
          dismissDirection: DismissDirection.up,
          content: Text(message, style: buttonfond),
          backgroundColor:
              status == 'success'
                  ? CleanerAppcolors.primarydarkGreencolor
                  : CleanerAppcolors.primaryRedcolor,
        ),
      );
      if (accept['status'] == 'success') {
        navigator.push(
          MaterialPageRoute(builder: (context) => DashboardView()),
        );
      }
    } catch (e) {
      loadingupdatewarehouse = false;
      notifyListeners();

      messenger.showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );

      print('Error: $e');
      throw {"error": e};
    }
  }

  List<bool> isDamagedList = [];
  List<List<XFile>> imagesPerBin = [];

  void initializeDamagedList(int count) {
    isDamagedList = List.generate(count, (_) => false);
    imagesPerBin = List.generate(count, (_) => []);
    notifyListeners();
  }

  void toggleCheckbox(int index, bool? value) {
    if (value != null && index >= 0 && index < isDamagedList.length) {
      isDamagedList[index] = value;
      notifyListeners();
    }
  }

  Future<void> pickImage(int index, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      int availableSlots = 3 - imagesPerBin[index].length;

      if (availableSlots <= 0) {
        showLimitSnackbar(context);
        return;
      }

      // Add only allowed number of images
      final filesToAdd = pickedFiles.take(availableSlots);
      imagesPerBin[index].addAll(filesToAdd);
      notifyListeners();

      if (pickedFiles.length > availableSlots) {
        showLimitSnackbar(context); // Notify user only 3 allowed
      }
    }
  }

  Future<void> captureImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null && imagesPerBin[index].length < 3) {
      imagesPerBin[index].add(pickedFile);
      notifyListeners();
    }
  }

  void removeImage(int binIndex, int imageIndex) {
    imagesPerBin[binIndex].removeAt(imageIndex);
    notifyListeners();
  }

  void showLimitSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You can only select up to 3 images.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void initializeControllers(int quantity) {
    serialControllers = List.generate(quantity, (_) => TextEditingController());
    binSerialNumbers = List.generate(quantity, (_) => "");
    notifyListeners();
  }

  void updateSerial(int index, String value) {
    if (index >= 0 && index < binSerialNumbers.length) {
      binSerialNumbers[index] = value;
      debugPrint('Updated Serial $index: $value');
    }
  }

  getUpdateAttachments(
    BuildContext context,
    String bookingid,
    String driverid,
  ) async {
    try {
      final messenger = ScaffoldMessenger.of(
        context,
      ); // ✅ Cache this before await
      final screenSize = MediaQuery.sizeOf(
        context,
      ); // ✅ Cache mediaQuery before await
      final navigator = Navigator.of(context);
        final amountText = paymentreceivecontroller.text.trim();
    final amountToSend = amountText.isEmpty ? '0' : amountText;
      var token = await Utils.getToken();
      loadingattachments = true;
      notifyListeners();

      final Map<String, dynamic> attachments = buildAttachmentData();

      final accept = await fetchUpdateAttachments(
        driverid,
        bookingid,
        attachments,
        token ?? '',
        amountToSend
      );
      loadingattachments = false;
      notifyListeners();
      if (accept['status'] == 'success') {
        navigator.push(CustomPageRoute(child: DashboardView()));
      }
      final status = accept['status'];
      final message = accept['message'] ?? 'No message';
      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: screenSize.height - 260.r,
              left: 10.r,
              right: 10.r,
            ),
            dismissDirection: DismissDirection.up,
            content: Text(message, style: buttonfond),
            backgroundColor:
                status == 'success'
                    ? CleanerAppcolors.primarydarkGreencolor
                    : CleanerAppcolors.primaryRedcolor,
          ),
        );
      }
    } catch (e) {
      loadingattachments = false;
      notifyListeners();

     

      print('Error: $e');
      throw {"error": e};
    }
  }

  getbookingdamage(
    BuildContext context,
    String bookingid,
    String driverid,
  ) async {
    try {
      final messenger = ScaffoldMessenger.of(
        context,
      ); // ✅ Cache this before await
      final screenSize = MediaQuery.sizeOf(
        context,
      ); // ✅ Cache mediaQuery before await
      final navigator = Navigator.of(context);
      var token = await Utils.getToken();
      loadingbookingdamage = true;
      notifyListeners();

      final Map<String, dynamic> bookingdamage = buildBookingDamages();

      final accept = await fetchbookingdamage(
        driverid,
        bookingid,
        bookingdamage,
        token ?? '',
      );
      print(accept);
      loadingbookingdamage = false;
      notifyListeners();
      if (accept['status'] == 'success') {
        navigator.pop();
      }
      final status = accept['status'];
      final message = accept['message'] ?? 'No message';
      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: screenSize.height - 170.r,
              left: 10.r,
              right: 10.r,
            ),
            dismissDirection: DismissDirection.up,
            content: Text(message, style: buttonfond),
            backgroundColor:
                status == 'success'
                    ? CleanerAppcolors.primarydarkGreencolor
                    : CleanerAppcolors.primaryRedcolor,
          ),
        );
      }
    } catch (e) {
      loadingbookingdamage = false;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }

      print('Error: $e');
      throw {"error": e};
    }
  }

  Map<String, dynamic> buildAttachmentData() {
    final serialNumbers = orderdetail?.bookingSerialNumbers ?? [];

    Map<String, dynamic> result = {};

    for (int i = 0; i < serialNumbers.length; i++) {
      final binId = serialNumbers[i].id?.toString();

      if (binId != null) {
        // Convert each image to base64
        List<String> base64Images =
            imagesPerBin[i].map<String>((xfile) {
              final file = File(xfile.path);
              final bytes = file.readAsBytesSync();
              return base64Encode(bytes);
            }).toList();

        result[binId] = {
          // 'isDamaged': isDamagedList[i],
          'images': base64Images, // Send base64-encoded images
        };
      }
    }

    return result;
  }

  Map<String, dynamic> buildBookingDamages() {
    final serialNumbers = orderdetail?.bookingSerialNumbers ?? [];

    Map<String, dynamic> result = {};

    for (int i = 0; i < serialNumbers.length; i++) {
      final binId = serialNumbers[i].id?.toString();

      if (binId != null) {
        result[binId] = {'isDamaged': isDamagedList[i]};
      }
    }

    return result;
  }
}

void showSafeSnackBar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required TextStyle textStyle,
  EdgeInsets? margin,
  Duration duration = const Duration(seconds: 3),
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // ⚠️ Only now check if the context is still mounted
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: margin,
          dismissDirection: DismissDirection.up,
          content: Text(message, style: textStyle),
          backgroundColor: backgroundColor,
          duration: duration,
        ),
      );
    } else {
      debugPrint('⚠️ Skipping snackbar because context is no longer mounted');
    }
  });
}
