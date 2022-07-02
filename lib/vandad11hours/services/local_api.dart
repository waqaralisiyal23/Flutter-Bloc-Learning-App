import 'dart:convert';

import 'package:bloclearning/vandad11hours/json_files/bloc/person.dart';
import 'dart:io';

abstract class LocalApi {
  static Future<List<Person>> getPersons(String url) async {
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    String stringData = await response.transform(utf8.decoder).join();
    List<dynamic> personsMapList = json.decode(stringData) as List<dynamic>;

    List<Person> personsList = [];
    for (Map<String, dynamic> personMap in personsMapList) {
      personsList.add(Person.fromMap(personMap));
    }

    return personsList;
  }
}
