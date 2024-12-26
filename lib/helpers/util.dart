import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

/// Chuyển đổi ngày `DateTime` sang chuỗi định dạng `dd/MM/yyyy`.
String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

/// Lấy địa chỉ từ tọa độ `LatLng`.
Future<String> getAddressFromLatLng(LatLng position) async {
  try {
    // Kiểm tra tọa độ hợp lệ
    if (position.latitude < -90 ||
        position.latitude > 90 ||
        position.longitude < -180 ||
        position.longitude > 180) {
      return 'Toạ độ không hợp lệ.';
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      // Ghép các thành phần địa chỉ có giá trị
      return [
        place.street,
        place.subLocality,
        place.locality,
        place.subAdministrativeArea,
        place.administrativeArea,
        place.country, // Thêm quốc gia nếu cần
      ]
          .where((element) => element != null && element.trim().isNotEmpty)
          .join(', ');
    } else {
      return 'Không tìm thấy địa chỉ tại toạ độ đã cho.';
    }
  } catch (e) {
    return 'Không thể lấy địa chỉ: $e';
  }
}
