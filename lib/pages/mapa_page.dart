import 'package:app_entrevista/bloc/ubicacion/ubicacion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

   @override
  void initState() { 
    //bien lo que vamos a hacer es mandar nuestra ubicacion actual en tiempo real es decir cada vez
    //que nos muevamos la variable de la ubicacion actual va estar cambiando
    
    //vamos a mandar a llamar el metodo que tenemos en nuestro bloc
    // ignore: close_sinks
    final ubicacionBloc = BlocProvider.of<UbicacionBloc>(context);
    ubicacionBloc.ubicacionCambio();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<UbicacionBloc, UbicacionState>(
        builder: (_, state){
          //los datos van a estar cambiando siempre que se cambie de lugar
          if(state.miUbicacion == null){
            return Center(
              child: CircularProgressIndicator()
            );
          }else{
            final posicionCamara = CameraPosition(
              target: state.miUbicacion,
              zoom: 17.0
            );
            return GoogleMap(
              initialCameraPosition: posicionCamara,
              //compassEnabled: true,
              //myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
            );
          }
        }
      )
    );
  }
}