class AppUrl {
//   static const mainUrl =
//       'http://nextlevelbins.com.au/api/';
  static const mainUrl = 'https://166d21068409.ngrok-free.app/api/';
  static const loginurl = '${mainUrl}login';
  static const binbooking = '${mainUrl}bin-bookings';
  static const myorder = '${mainUrl}bin-bookings/order?driver_id=';
  static const acceptrequest = '${mainUrl}bin-bookings/accept';
  static const updateserialnumber =
      '${mainUrl}bin-bookings/update-serial-number/';
  static const binbookingdetails = '${mainUrl}bin-bookings/';
  static const logout = '${mainUrl}logout';
  static const updateattachments =
      '${mainUrl}bin-bookings/update-booking-attachments/';
  static const confirmonsitedelivery =
      '${mainUrl}bin-bookings/on-site-delivered/';
  static const confirmwarehousedelivery =
      '${mainUrl}bin-bookings/warehouse-delivered/';
  static const bookingdamage =
      '${mainUrl}bin-bookings/update-booking-serial-damage/';
}
