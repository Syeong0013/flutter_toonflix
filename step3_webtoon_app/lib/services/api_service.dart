import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:step3_webtoon_app/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];

    final uri = Uri.parse('$baseUrl/$today');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons =
          jsonDecode(response.body); // stirng to JSON
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
