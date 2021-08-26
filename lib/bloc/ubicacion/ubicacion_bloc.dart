import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'ubicacion_event.dart';
part 'ubicacion_state.dart';

class UbicacionBloc extends Bloc<UbicacionEvent, UbicacionState> {
  UbicacionBloc() : super(UbicacionState());


  StreamSubscription<Position> _ubicacion;

  //vamos a definir un metodo que nos va a ayudar para estar escuchando los cambios de ubicacion
  void ubicacionCambio(){
    //ahora si señores vamos a comenzar comienza lo bueno
    this._ubicacion = Geolocator.Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen(( posicion ) { 
      //bien lo que aqui vamos a hacer es devolver la posicion en donde esta el usuario
      //ahora vamos a almacenar esto es una clase de tipo LatLng
      final coordenadas = new LatLng(posicion.latitude, posicion.longitude);
      //bien ya que tenemos todo eso ahora si lo que vamos a hacer es mandar a llamar el evento
      add( MiUbicacion(coordenadas) );
    });
  }

  void cancelarSeguimiento(){
    _ubicacion?.cancel();
  }


  @override
  Stream<UbicacionState> mapEventToState(UbicacionEvent event) async* {
    // TODO: implement mapEventToState
    if( event is MiUbicacion){
      //bien vamos a devolver una nueva instancia de la clase pero ahora con nuestra ubicacion
      yield state.copyWith(
        miUbicacion: event.ubicacion
      );
    }
  }
}
