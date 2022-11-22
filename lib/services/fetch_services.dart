import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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

  Future deletePost(int id, int postId) async {
    Response res = await http.delete(Uri.parse("https://63347899ea0de5318a039283.mockapi.io/intesa/mobil/post/0/comment/${id}"));

    if (res.statusCode == 200) {
      print("Deleted");
    } else {
      throw "Sorry!";
    }
  }
}