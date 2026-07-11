import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/facility.dart';
import '../models/search_condition.dart';

part 'facility_forecast.g.dart';

@riverpod
class Forecast extends _$Forecast {
  @override
  Future<Map<String, Facility>> build() async {
    final (depID, dir, target) = ref.watch(condProvider.select(
      (cond) => (cond.depID, cond.direction, cond.target)
    ));
    if (target.date == null)  return {};

    final collectionRef = Firebase.apps.isEmpty ?
        null : FirebaseFirestore.instance.collection('romancecar');
    final doc = await collectionRef
        ?.doc(DateFormat('yyyy-MM-dd').format(target.date!)).get();
    return doc?.exists == true ? doc?.data()?.map((key, value) => MapEntry(
      key, Facility.fromJson(Map<String, dynamic>.from(value as Map))
    )) ?? {} : {};
  }
}
