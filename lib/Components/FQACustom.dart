import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Models/FQAModel.dart';
import 'package:freshwavelaundry/api_services/FAQ.dart';

class customFAQ extends StatefulWidget {
  final length;
  final physics;
  const customFAQ({super.key, this.length, this.physics});

  @override
  State<customFAQ> createState() => _customFAQListState();
}

class _customFAQListState extends State<customFAQ> {
  Future<List<FAQItem>>? faqItemsList;

  void initState() {
    super.initState();
    faqItemsList = fetchFAQItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FAQItem>>(
      future: faqItemsList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No FAQ items found'));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final faqItems = snapshot.data!;
          // Use faqItems in your UI
          return ListView.builder(
              physics: widget.physics,
              shrinkWrap: true,
              itemCount:
                  widget.length != null ? widget.length : snapshot.data!.length,
              itemBuilder: ((context, index) {
                final data = snapshot.data![index];
                return Column(
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey.shade300)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey.shade300)),
                        title: Text(data.question,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        children: [
                          Text(data.answer,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700]))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              }));
        }
      },
    );
  }
}
