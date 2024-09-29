import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Models/FQAModel.dart';
import 'package:freshwavelaundry/api_services/global.dart';

Future<List<FAQItem>> fetchFAQItems() async {
  final apiUrl = '${APIservice.address}/FAQ/allfqa';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);

    List<FAQItem> faqItemsList = [];
    for (var data in responseData) {
      final item = FAQItem.fromJson(data);
      faqItemsList.add(item);
    }

    print(faqItemsList);

    return faqItemsList;
  } else {
    throw Exception('Failed to load FAQ items from API');
  }
}
