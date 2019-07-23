import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper{

  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    Response response= await get(url);
    print(response.statusCode);
    return jsonDecode(response.body);

    }
  }
