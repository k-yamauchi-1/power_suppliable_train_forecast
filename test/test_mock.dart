import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';

void main() {
  final override = serviceProvider.overrideWithValue(AsyncData(const Service(id: 'a', service: 'b', companyName: 'c', companyShortName: 'd', stations: {}, facilities: {}, trains: {})));
}
