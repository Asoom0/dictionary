
import 'package:dio/dio.dart';

 class DataSource{

   Dio dio = Dio();
     Future<Map<String, dynamic>> search(String word) async{

       final response = await dio
           .get("https://api.dictionaryapi.dev/api/v2/entries/en/$word");
       final data = (response.data[0]) as Map<String, dynamic>;
       return data;
     }
}