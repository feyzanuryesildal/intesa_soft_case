import 'package:flutter/foundation.dart';

import '../model/model_data.dart';
import '../services/fetch_services.dart';

enum DataState { IDLE, BUSY, ERROR }

class DataViewModel with ChangeNotifier {
  late DataState _state;

  late List<modelData> dataList;

  DataViewModel() {
    dataList = [];
    _state = DataState.IDLE;
    fetchJobs();
  }

  DataState get state => _state;
  set state(DataState state) {
    _state = state;
    notifyListeners();
  }

  Future<List<modelData>> fetchJobs() async {
    try {
      state = DataState.BUSY;
      dataList = await WebService().fetchJobs();
      state = DataState.IDLE;
      return dataList;
    } catch (e) {
      state = DataState.ERROR;
      return [];
    }
  }
}