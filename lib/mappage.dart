import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';

// Import the file where MyHomePage is defined
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  loc.Location _location = loc.Location();
  late bool _serviceEnabled;
  late loc.PermissionStatus _permissionGranted;
  late loc.LocationData _locationData;
  List<Marker> _markers = [];
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _locations = [];

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(36.305216, 127.343963),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _loadMarkersFromJson();
  }

  Future<void> _requestPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    _location.onLocationChanged.listen((loc.LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
      });
      _updateLocationOnMap();
    });
  }

  void _updateLocationOnMap() async {
    final GoogleMapController controller = await _controller.future;
    if (_locationData != null) {
      controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(_locationData.latitude!, _locationData.longitude!),
      ));
    }
  }

  Future<void> _loadMarkersFromJson() async {
    final String response = await rootBundle.loadString('assets/애니메이션_장소_위치_정보.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _locations = data.map<Map<String, dynamic>>((item) => item as Map<String, dynamic>).toList();
      _markers = _locations.map((item) {
        return Marker(
          markerId: MarkerId(item['Search Name']),
          position: LatLng(item['Latitude'], item['Longitude']),
          infoWindow: InfoWindow(
            title: item['Search Name'],
            snippet: item['Address'],
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }).toList();
    });
  }

  void _zoomIn() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }

  Future<void> _searchLocation() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      try {
        // JSON 파일의 장소와 일치하는지 확인
        Map<String, dynamic>? matchingLocation;
        for (var location in _locations) {
          if (location['Search Name'] == query) {
            matchingLocation = location;
            break;
          }
        }

        final GoogleMapController controller = await _controller.future;
        if (matchingLocation != null) {
          // JSON 파일의 장소와 일치하는 경우 해당 위치로 이동
          LatLng target = LatLng(matchingLocation['Latitude'], matchingLocation['Longitude']);
          controller.animateCamera(CameraUpdate.newLatLng(target));
        } else {
          // JSON 파일의 장소와 일치하지 않는 경우 지오코딩 API를 사용하여 검색
          List<Location> locations = await locationFromAddress(query);
          if (locations.isNotEmpty) {
            Location location = locations.first;
            LatLng target = LatLng(location.latitude, location.longitude);

            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId(query),
                  position: target,
                  infoWindow: InfoWindow(
                    title: query,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                ),
              );
            });

            controller.animateCamera(CameraUpdate.newLatLng(target));
          }
        }
      } catch (e) {
        // 검색 실패 시 처리
        print("Location not found: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지도 페이지'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              if (_locationData != null) {
                _updateLocationOnMap();
              }
            },
            onCameraMove: (CameraPosition cameraPosition) {},
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
            ].toSet(),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '장소 검색',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchLocation,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: Icon(Icons.add),
                  heroTag: null,
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: Icon(Icons.remove),
                  heroTag: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
