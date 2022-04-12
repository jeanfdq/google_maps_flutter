import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_trips/components/dialog.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  static const id = "/map";

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  var _cameraPosition = const CameraPosition(
    target: LatLng(0, 0),
  );

  @override
  void initState() {
    super.initState();

    _getLastLocation();
    _listenerLocation();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final isAuthorized = await _verifyPermissionLocation();
      if (!isAuthorized) {
        Get.back();
      }
    });

    SchedulerBinding.instance?.addPostFrameCallback((_) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _getLastLocation() async {
    final position = await Geolocator.getLastKnownPosition();

    setState(() {
      if (position != null) {
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 17);
      }
    });
    _moveCamera(_cameraPosition);
  }

  _listenerLocation() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((position) {
      setState(() {
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 17);
      });
      _moveCamera(_cameraPosition);
    });
  }

  _moveCamera(CameraPosition cameraPosition) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<bool> _verifyPermissionLocation() async {
    var isAuthorized = true;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isAuthorized = false;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return DialogConfirm(
                title: "GeoLocalização",
                content:
                    "Desculpe, mas precisamos da sua localização para continuar!",
                confirm: () => Get.back());
          }).then((_) {
        return false;
      });
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isAuthorized = false;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return DialogConfirm(
                  title: "GeoLocalização",
                  content:
                      "Desculpe, mas precisa autorizar acesso a sua localização atual para continuar!",
                  confirm: () => Get.back());
            }).then((_) {
          return false;
        });
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isAuthorized = false;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return DialogConfirm(
                title: "GeoLocalização",
                content:
                    "Desculpe, mas precisa autorizar acesso a sua localização atual para continuar!",
                confirm: () => Get.back());
          }).then((_) {
        return false;
      });
    }
    return isAuthorized;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escolha seu destino..."),
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}
