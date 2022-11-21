import 'package:http/http.dart' as http;

import '../constant/application_constants.dart';
import '../model/model_data.dart';

class WebService {
  Future<List<modelData>> fetchJobs() async {
    final response = await http.get(Uri.parse(ApplicationConstants.API_URL));
    if (response.statusCode == 200) {
      return modelDataFromJson(response.body);
    }
    return [];
  }
}