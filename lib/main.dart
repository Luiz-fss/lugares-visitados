import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> GreatPlace(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Great Places",
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (context) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (context) => PlaceDetailScreen(),
        }),
    );
  }
}
