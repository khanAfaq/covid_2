import 'dart:convert';

import 'package:covid/Utilites/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:covid/Model/world_state_model.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error :(');
    }
  }

  Future<List<dynamic>> CountriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error :(');
    }
  }
}
