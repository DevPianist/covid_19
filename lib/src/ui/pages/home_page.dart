import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/api_model.dart';
import '../../providers/coronavirus_api.dart';
import '../../blocs/api_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: CoronavirusApi.getCases(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List<ApiModel> listCases = snapshot.data;
              return ListView.builder(
                itemCount: listCases.length,
                itemBuilder: (BuildContext context, int i) {
                  ApiModel cases = listCases[i];
                  return Card(
                    elevation: 6,
                    child: Container(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Confirmados",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "${cases.confirmed}",
                              style: TextStyle(
                                  color: Colors.red[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        title: Text(
                          "${cases.countryRegion}",
                        ),
                        subtitle: Text(
                            "Muertes: ${cases.deaths} Recuperados: ${cases.recovered}"),
                      ),
                    ),
                  );
                },
              );
            } else
              return Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
      floatingActionButton: StreamBuilder(
        stream: ApiBloc.getInstance().streamApi,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return FloatingActionButton(
              child: Icon(Icons.location_on),
              onPressed: () => Navigator.pushNamed(context, '/map'),
            );
          } else
            return Container();
        },
      ),
    );
  }
}
