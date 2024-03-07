import 'package:get/get.dart';

class NoteController extends GetxController {
  RxList<String> notes = <String>[].obs;

  void addNote(String note) {
    notes.add(note);
  }

  void editNote(int index, String note) {
    notes[index] = note;
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }
}
