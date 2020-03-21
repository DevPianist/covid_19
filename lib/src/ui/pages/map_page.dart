import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../../blocs/api_bloc.dart';
import '../../utils/utils.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  ApiBloc apiBloc = ApiBloc.getInstance();
  List<Marker> markers;

  @override
  void initState() {
    markers = apiBloc.apiRepository.listMarkers;
    super.initState();
  }

  static final CameraPosition _initial = CameraPosition(
    target: LatLng(-12.195444, -76.9741501),
    zoom: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Casos COVID-19 en el mundo"),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapToolbarEnabled: false,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _initial,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(Utils.mapStyles);
          _controller.complete(controller);
        },
        markers: markers.toSet(),
      ),
    );
  }
}
