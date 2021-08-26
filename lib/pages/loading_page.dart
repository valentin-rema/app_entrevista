import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:geolocator/geolocator.dart' as Geolocator;


class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
    void initState() {
      WidgetsBinding.instance.addObserver(this);
      super.initState();
    }

    @override
    void dispose() {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    }

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) async {
      //bien ahora vamos a estar a la escucha de las opciones

      if(state == AppLifecycleState.resumed){
          //si la aplicacion esta activa ahora vamos a poner si esta habilitado la parte de la ubicacion
          if( await Geolocator.Geolocator.isLocationServiceEnabled() ){
              //ahora si tenemos encendido tambien la parte de la ubicacion entonces 
              Navigator.pushReplacementNamed(context, 'mapa');
          }
      }
      super.didChangeAppLifecycleState(state);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsandLocation(),
        builder: ( _, AsyncSnapshot<String> snapshot ){
          //bien ahora vamos a ver si tenemos algun dato
          if(snapshot.hasData){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data, style: TextStyle(fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 5.0,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      //y por ultimo cuando presionemos este boton vamos a mostrar la parte de encender
                      //la ubicacion
                      await Geolocator.Geolocator.openLocationSettings();
                      //devuelve un true si es que se abrio la parte de los ajustes de localizacion
                    },
                    child: Text('Activar Ubicacion', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    color: Colors.black87,
                    shape: StadiumBorder()
                  ) 
                ],
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2.0)
            );
          }
        }
      )
    );
  }

  Future<String> checkGpsandLocation() async {
    //bien señores lo primero que vamos a hacer es verificar que efectivamente tenemos activado la 
    //opcion de gps
    final permisoGps = await Permission.location.isGranted;
    if(!permisoGps){
      //si no tenemos activos los permisos de gps entonces 
      Navigator.pushReplacementNamed(context, 'screen');
    }
    //ahora tenemos que ver la forma de visualizar si la ubicacion la tenemos activa
    if( !await Geolocator.Geolocator.isLocationServiceEnabled() ){
      //si tenemos activo lo que es la parte del gps pero no tenemos activo al ubicacion entonces 
      //mandamos esto
      return 'Para utilizar esta app tiene que encender su ubicacion';
    }else{
      //si es que todo lo tenemos activo entonces nos vamos a la parte del mapa
      Navigator.pushReplacementNamed(context, 'mapa');     
    }
  }
}