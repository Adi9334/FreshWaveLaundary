import 'package:freshwavelaundry/Models/counter_model.dart';
import 'package:freshwavelaundry/Screens/Booking_item_screen.dart';

class item_model {
  final id;
  final name;
  final image;
  final price;
  // final CounterModel counter;

  item_model({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    // required this.counter,
  });

  factory item_model.fromJson(Map<String, dynamic> json) {
    return item_model(
      id: json['id'],
      name: json['service_item_name'],
      image: json['service_item_imageURL'],
      price: json['service_item_price'],
      // counter: CounterModel(),
    );
  }
}
