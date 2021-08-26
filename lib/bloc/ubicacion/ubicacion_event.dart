part of 'ubicacion_bloc.dart';

@immutable
abstract class UbicacionEvent {}


//ahora si señores vamos a definir los eventos que necesitemos 
class MiUbicacion extends UbicacionEvent{
  //variable que necesitamos
  final LatLng ubicacion;
  MiUbicacion(this.ubicacion);
}