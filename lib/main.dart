
import 'package:dictionary/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/controller.dart';


 void main() {
  runApp( MyApp());
}

 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   @override
   Widget build(BuildContext context) {
     return  BlocProvider(
         create: (_) => DictionaryCubit(),
     child: MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomeScreen(),
     ),
     );
   }
 }
