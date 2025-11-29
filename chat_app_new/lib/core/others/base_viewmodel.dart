import 'package:chat_app_new/core/enum/enums.dart';
import 'package:flutter/material.dart';

//Model provider สำหรับการอ่านสถานะจากข้างนอก และ เปลี่ยนสถานะต่างๆ
//เช่นการรอคำสั่ง ถ้าคำสั่งยังไม่มาให้แสดงการloading ถ้ามาแล้วแสดงข้อมูลเป็นต้น
//getter คือตัวที่ให้ข้างนอกสามารถอ่านข้อมูลได้ว่าตอนนี้เป็นอะไร เช่น เป็น idle หรือ loading
class BaseViewmodel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  setstate(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
