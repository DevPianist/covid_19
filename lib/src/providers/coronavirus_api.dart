import 'package:http/http.dart' as http;
import 'dart:convert';
import '../blocs/api_bloc.dart';
import '../models/api_model.dart';

class CoronavirusApi {
  static Future<List<ApiModel>> getCases() async {
    ApiBloc apiBloc = ApiBloc.getInstance();
    final apiRepository = apiBloc.apiRepository;
    if (apiRepository.listApi.isEmpty) {
      final String _url =
          'https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/latest?onlyCountries=true';
      final http.Response response = await http.get(
        _url,
      );
      final parsed = jsonDecode(response.body);
      List<ApiModel> listApi = ApiModel.fromJSONList(parsed);
      apiBloc.updateListApi(listApi);
      print("Data length: ${apiRepository.listApi.length}");
      return listApi;
    } else
      return apiRepository.listApi;
  }
}
