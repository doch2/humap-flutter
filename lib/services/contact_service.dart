import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:humap/services/auth_service.dart';

class ContactService extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  getContactList() async {
    try {
      List<Contact> contactList = await FlutterContacts.getContacts();
      return contactList;
    } catch (e) {
      return [];
    }
  }
}