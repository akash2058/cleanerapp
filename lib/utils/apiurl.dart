class AppUrl {
  static const mainUrl =
      'https://8db2-2404-7c00-41-4ea5-c412-10e-5d13-a9f6.ngrok-free.app/api/';
  // static const mainUrl = 'http://127.0.0.1:8000/api/';
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
