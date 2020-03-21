import 'dart:async';
import 'package:rxdart/subjects.dart';

import 'api_repository.dart';

class ApiBloc {
  //singleton
  ApiBloc._privateConstructor();
  static ApiBloc _instance;
  static ApiBloc getInstance() {
    if ((_instance == null)) _instance = ApiBloc._privateConstructor();

    return _instance;
  }

  final StreamController _listApiController = BehaviorSubject();
  ApiRepository apiRepository = new ApiRepository();

  Stream get streamApi => _listApiController.stream;

  void updateListApi(List listApi) {
    apiRepository.updateListApi(listApi);
    _listApiController.sink.add(apiRepository.listApi);
  }

  void dispose() {
    _listApiController.close();
  }
}
