//vamos a comenzar entonces
import 'package:app_entrevista/bloc/ubicacion/ubicacion_bloc.dart';
import 'package:app_entrevista/pages/loading_page.dart';
import 'package:app_entrevista/pages/mapa_page.dart';
import 'package:flutter/material.dart';
import 'package:app_entrevista/pages/screen_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider(create: ( _ ) => UbicacionBloc()),
          //BlocProvider(create: ( _ ) => MapaBloc()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'screen',
        routes: {
          'loading'   : (_) => LoadingPage(),
          'screen'    : (_) => ScreenPermisos(),
          'mapa'      : (_) => MapaPage()
        }
      ),
    );
  }
}
