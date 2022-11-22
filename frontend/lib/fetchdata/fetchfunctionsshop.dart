import 'dart:convert';

import '../classess/categories.dart';
import '../classess/itembases.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../urls.dart';

fetchNewestNews(session) async {
  List<News> newestnewslist = [];
  final queryParameters = {
    'count': '3', // how many news it should show
  };
  final response = await session.get(geturlNewestNews(queryParameters));

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseNews = jsonDecode(utf8.decode(response.bodyBytes));
    responseNews['results'].forEach((element) {
      newestnewslist.add(News.fromMap(element));
    });
    return newestnewslist;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load News');
  }
}

fetchNewestOffers(session) async {
  List<Offers> responsenewestOffers = [];
  final queryParameters = {
    'count': '3', // how many offers it should show
  };
  final response = await session.get(geturlNewestOffers(queryParameters));

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseOffers = jsonDecode(utf8.decode(response.bodyBytes));
    responseOffers['results'].forEach((element) {
      responsenewestOffers.add(Offers.fromMap(element));
    });
    print(responseOffers);
    return responsenewestOffers;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load News');
  }
}

fetchItembase(session, int id) async {
  Itembases itembase;
  final response = await session.get(geturlItembase(id));

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseItembase = jsonDecode(utf8.decode(response.bodyBytes));
    print('responseITEMBASEEEEEEEEEEEEEEEEEEEEEEE $responseItembase');
    itembase = Itembases.fromMap(responseItembase);
    print(itembase);
    return itembase;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load itembase');
  }
}

fetchCategories(session) async {
  List<Categories> responseCategories = [];
  final response = await session.get(geturlCategories());

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseCategories1 = jsonDecode(utf8.decode(response.bodyBytes));
    responseCategories1['results'].forEach((element) {
      responseCategories.add(Categories.fromMap(element));
    });
    print(responseCategories);
    return responseCategories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Categories');
  }
}
