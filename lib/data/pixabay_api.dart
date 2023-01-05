import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pixabay/model/pixabay.dart';

class PixabayApi {
  Future<List<Pixabay>> fetchPixabay(String query) async {
    const baseUrl = 'https://pixabay.com/api/';
    const key = '24806095-fea70a37f71c6222b27afd5be';

    final response = await http.get(Uri.parse(
        '$baseUrl?' 'key=$key&q=$query&image_type=photo&pretty=true'));

    if (response.statusCode == 200) {
      List jsonResult = jsonDecode(response.body)['hits'];
      return jsonResult.map((e) => Pixabay.fromJson(e)).toList();
    } else {
      throw Exception('Fail to load Pixabay Data');
    }
  }
}
