import 'package:get/get.dart';
import 'package:money_record/data/model/user.dart';

class Cuser extends GetxController{
  final _data = User().obs;
  User get data => _data.value;
  setData(n) => _data.value = n;
  // static void setData(User user) {}
}