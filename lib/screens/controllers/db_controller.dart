import 'dart:async';
import 'package:get/get.dart';
import 'package:users_data/services/database/db_test.dart';
import '../models/db_model.dart';

class ProductController extends GetxController {

  List<StoreData> userList = [];
  late Timer _updateTimer;

  @override
  void onInit() {
    super.onInit();
    startUpdating();
  }

  void startUpdating() {
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchProducts(); // Call fetchProducts() every second
    });
  }

  void fetchProducts() async {
    final data = await DbTesting.instance.getAllData();
    if (userList.isEmpty) {
      userList = data!.cast<StoreData>();
    } else {
      userList.clear();
      userList = data!.cast<StoreData>();
    }
    update();
  }

  @override
  void onClose() {
    _updateTimer.cancel();
    super.onClose();
  }
}