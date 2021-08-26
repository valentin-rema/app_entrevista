//vamos a comenzar entonces con los permisos
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:geolocator/geolocator.dart' as Geolocator;


class ScreenPermisos extends StatefulWidget {

  @override
  _ScreenPermisosState createState() => _ScreenPermisosState();
}

class _ScreenPermisosState extends State<ScreenPermisos> with WidgetsBindingObserver{


  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

  }

  @override
    void didChangeAppLifecycleState(AppLifecycleState state) async {
      // TODO: implement didChangeAppLifecycleState
      super.didChangeAppLifecycleState(state);
      //bien vamos a ver los estados que tiene nuestra aplicacion
      print('=====>>>>>>>$state');

      //bien ahora ya que hemos imprimido los estados de la aplicacion vamos a hacer una condicional 
      //desde el principio para saber si los permisos ya estan desde antes
      final permisoInicial = await Permission.location.isGranted;

      //ahora vamos a ver si el permiso ya estaba activo desde el principio
      if( state == AppLifecycleState.resumed){
          if(permisoInicial){
              //vamos a pasarnos de una vez a la parte del loading
              Navigator.pushReplacementNamed(context, 'loading');
          }
      }

      super.didChangeAppLifecycleState(state);
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //ahora vamos a poner el letrero y el boton
              Text('Para utilizar la app necesita permisos de ubicacion', style: TextStyle(fontWeight: FontWeight.w400)),
              SizedBox(height: 5.0),
              MaterialButton(
               onPressed: () async {
                    //ahora cuando presionemos el boton vamos a pedir permisos de gps
                    final permisoGps = await Permission.location.request(); 

                    //vamos a mandar nuestra respuesta a una funcion
                    this.verificandoGps(permisoGps, context);
                },
                child: Text('Activar Gps', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                color: Colors.black87,
                shape: StadiumBorder(),
              )
            ],
          )
        ),
    );
  }

  verificandoGps(PermissionStatus permiso, BuildContext context){
      //en esta parte lo que vamos a hacer es que dependiendo de la respuesta vamos a actuar de forma
      //diferente
      switch(permiso){
        case PermissionStatus.granted:
          //cuando damos el permiso desde el principio entonces simplemente lo vamos a mandar a la parte 
          //del loading
          Navigator.pushReplacementNamed(context, 'loading');
          break;
        case PermissionStatus.undetermined:
        case PermissionStatus.denied:
        case PermissionStatus.restricted:
        case PermissionStatus.permanentlyDenied:
        case PermissionStatus.limited:
          //bien si cae en esta parte vamos a mandar al usuario a una ventana donde forzosamente tiene que 
          //dar los permisos
          Geolocator.Geolocator.openAppSettings();
      }
  }
}

