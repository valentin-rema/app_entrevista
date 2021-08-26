part of 'ubicacion_bloc.dart';

class UbicacionState{

  //Definamos las variables
  final LatLng miUbicacion;

  //las llaves significan que se puede inicializar con esa variable o puede ir vacio
  UbicacionState({
    this.miUbicacion
  });

  //bien ahora vamos a definir el metodo que nos va a devolver la misma intancia solo con algunos 
  //cambios
  UbicacionState copyWith({ 
    LatLng miUbicacion 
  }) =>
  new UbicacionState(
    miUbicacion : miUbicacion ?? this.miUbicacion
  );

}