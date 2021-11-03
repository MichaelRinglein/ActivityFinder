import 'dart:convert';

import 'package:boredapi/single_activity.dart';
import 'package:http/http.dart' as http;

class ActivitiesServices {
  Future<SingleActivity> getSingleActivity() async {
    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SingleActivity.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
