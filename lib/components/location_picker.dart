import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class LocationPicker extends StatefulWidget {
  final Function(LatLng) onLocationSelected; // Hàm callback khi chọn vị trí
  final String label; // Nhãn cho input map

  const LocationPicker({
    super.key,
    required this.onLocationSelected,
    this.label = "Chọn vị trí",
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final MapController _mapController = MapController(); // MapController
  LatLng _selectedPosition =
      const LatLng(21.028511, 105.804817); // Mặc định Hà Nội
  String _address = "Đang lấy vị trí...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception("Dịch vụ vị trí không được bật");

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          throw Exception("Quyền truy cập vị trí bị từ chối vĩnh viễn");
        } else if (permission == LocationPermission.denied) {
          throw Exception("Quyền truy cập vị trí bị từ chối");
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _selectedPosition = LatLng(position.latitude, position.longitude);
      _getAddressFromLatLng(_selectedPosition);
      _mapController.move(_selectedPosition, 18.0); // Di chuyển map
    } catch (e) {
      setState(() {
        _address = e.toString();
      });
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address = [
            place.street,
            place.subLocality,
            place.locality,
            place.subAdministrativeArea,
            place.administrativeArea,
          ]
              .where((element) => element != null && element.isNotEmpty)
              .join(', ');
        });
      }
    } catch (e) {
      setState(() {
        _address = "Không thể lấy địa chỉ: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Row(
            children: [
              Text(
                widget.label,
                style: kLableSize15Black,
              ),
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Hiển thị địa chỉ
          Text(
            _address,
            style: kLableSize15Black,
          ),
          const SizedBox(height: 10),
          // Bản đồ
          SizedBox(
            height: 250,
            width: double.infinity,
            child: FlutterMap(
              mapController: _mapController, // Gắn MapController
              options: MapOptions(
                initialCenter: _selectedPosition,
                initialZoom: 18.0,
                minZoom: 1.0,
                maxZoom: 19.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedPosition = point;
                  });
                  _mapController.move(point, 18.00); // Di chuyển map
                  _getAddressFromLatLng(point); // Lấy địa chỉ mới
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedPosition,
                      width: 80.0,
                      height: 80.0,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
