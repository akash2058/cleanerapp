class AppUrl {
  static const mainUrl =
      ' https://9fdb-2404-7c00-41-695d-d586-6190-b4fa-c1c4.ngrok-free.app/api/';
  // static const mainUrl = 'http://127.0.0.1:8000/api/';
  static const loginurl = '${mainUrl}login';
  static const binbooking = '${mainUrl}bin-bookings';
  static const myorder = '${mainUrl}bin-bookings/order?driver_id=';
  static const acceptrequest = '${mainUrl}bin-bookings/accept';
  static const updateserialnumber =
      '${mainUrl}bin-bookings/update-serial-number/';
  static const binbookingdetails = '${mainUrl}bin-bookings/';
  static const logout = '${mainUrl}logout';
  static const updateattachments = '${mainUrl}bin-bookings/update-booking-attachments/';
    static const confirmonsitedelivery = '${mainUrl}bin-bookings/on-site-delivered/';
    static const confirmwarehousedelivery = '${mainUrl}bin-bookings/warehouse-delivered/';

}
