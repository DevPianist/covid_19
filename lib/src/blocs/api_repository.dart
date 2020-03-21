import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/api_model.dart';

import 'dart:io' show Platform;

class ApiRepository {
  List<ApiModel> listApi = new List<ApiModel>();
  List<Marker> listMarkers = new List<Marker>();
  void updateListApi(List<ApiModel> list) async {
    String pathImage = 'assets/images/';
    //En android los marcadores tienen un tamaño distinto
    //ImageConfiguration no realiza ningun cambio en el mapa
    if (Platform.isAndroid)
      pathImage += 'covid2.png';
    else if (Platform.isIOS) pathImage += 'covid.png';

    BitmapDescriptor.fromAssetImage(ImageConfiguration(), pathImage).then(
      (onValue) {
        list.forEach(
          (e) {
            listMarkers.add(
              Marker(
                draggable: true,
                markerId: MarkerId('${e.location.lat}'),
                position: LatLng(e.location.lat, e.location.long),
                icon: onValue,
                infoWindow: InfoWindow(
                    title: "${e.countryRegion}",
                    snippet: (Platform.isAndroid)
                        ? "Confirmados: ${e.confirmed} Muertes: ${e.deaths} Recuperados: ${e.recovered}"
                        : "Confirmados: ${e.confirmed}\nMuertes: ${e.deaths}\nRecuperados: ${e.recovered}"
                    //En android no funciona el salto de linea...
                    ),
              ),
            );
          },
        );
      },
    );
    this.listApi = list;
  }
}
