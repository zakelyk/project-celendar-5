import 'package:celendar/app/modules/home/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:celendar/app/modules/home/controllers/note_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart'; // Impor WebView
import 'package:celendar/main.dart';

class MyAppState extends State<MyHomePage> {
  final AuthController _authController = Get.put(AuthController());
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final TextEditingController _noteController = TextEditingController();
  final NoteController _noteControllerGetX = Get.find();

  Map<DateTime, List> _events = {};
  bool _loadingHolidays = true;
  final WebView _webView = WebView(
    initialUrl: 'https://www.bmkg.go.id/cuaca/prakiraan-cuaca-indonesia.bmkg',
    javascriptMode: JavascriptMode.unrestricted,
  );

  @override
  void initState() {
    super.initState();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    final url = Uri.parse(
        'https://calendarific.com/api/v2/holidays?api_key=B1mLm0kZvRrgJHckLbcoe3nPPZtzSpJK&country=US&year=2023');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final holidays = data['response']['holidays'];

      for (var holiday in holidays) {
        final date = DateTime.parse(holiday['date']['iso']);
        final name = holiday['name'];
        _events[date] = [name];
      }

      setState(() {
        _loadingHolidays = false;
      });
    } else {
      setState(() {
        _loadingHolidays = false;
      });
      print('Failed to load holidays.');
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _showNoteForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(labelText: 'Note'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String noteText = _noteController.text;
                _noteControllerGetX.addNote(noteText);
                _noteController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteForm(BuildContext context, int index) {
    _noteController.text = _noteControllerGetX.notes[index];
    showDialog(context: context,builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(controller: _noteController,decoration: InputDecoration(labelText: 'Note'),),
          actions: [
            TextButton(
              onPressed: () {Navigator.of(context).pop();},
              child: Text('Cancel'),
            ),
            ElevatedButton(onPressed: () {
                String noteText = _noteController.text;
                _noteControllerGetX.editNote(index, noteText);
                _noteController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  List<String> _getEventsForDay(DateTime day) {
    final events = _events[day];
    if (events != null) {
      return List<String>.from(events);
    }
    return [];
  }

  void _openWebView() {
    Get.to(() => Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
        backgroundColor: Color(0xFF323335),
      ),
      body: _webView,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector( onTap: () {
          if (_authController.isLoggedIn.value == true) {
            Get.toNamed('/profile');
          } else {
            Get.toNamed('/login');}
        //   Get.toNamed('/profile');
          },
          child: Text('   Calendar',style: TextStyle(fontSize: 25.0,fontFamily: 'WhiteOnBlack',color: Colors.white,),),),
        backgroundColor: Color(0xFF323335),
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.cloud),onPressed: _openWebView, ),],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {_showNoteForm(context);},child: Icon(Icons.add),backgroundColor: Colors.green,),
      body: DefaultTabController(length: 3, // Menambahkan tab notifikasi hari libur
        child: Column(children: <Widget>[
            Container(color: Color(0xFF323335),child: Center(
                child: TableCalendar(firstDay: DateTime(2000, 1, 1),lastDay: DateTime(2030, 12, 31),focusedDay: _focusedDay,selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);},
                  onDaySelected: (selectedDay, focusedDay) {setState(() {_selectedDay = selectedDay;_focusedDay = focusedDay;});},
                  calendarStyle: CalendarStyle(todayDecoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle,border: Border.all(color: Colors.amberAccent,width: 1.0,),),
                    selectedDecoration: BoxDecoration(color: Colors.green,shape: BoxShape.circle,border: Border.all(color: Colors.greenAccent,width: 2.0,),),
                    weekendTextStyle: TextStyle(color: Colors.red,),),
                  eventLoader: _getEventsForDay,
                ),
              ),
            ),
            TabBar(tabs: [
                Tab(text: 'Note 💀'),
                Tab(text: 'Holidays 🎉'),
              ],
            ),
            Expanded(child: TabBarView(children: [
              Padding(padding: const EdgeInsets.all(16.0),child: Obx(() {
                      return _noteControllerGetX.notes.isEmpty
                          ? Center( child: Text('Nothing Here, Please fill Your Plan/Schedule',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.normal,),),)
                          : ListView.builder(itemCount: _noteControllerGetX.notes.length,itemBuilder: (context, index) {
                              return Card(child: ListTile(
                                title: Text(_noteControllerGetX.notes[index]),
                                trailing: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditNoteForm(context, index);
                                  } else if (value == 'delete') {
                                    _noteControllerGetX.deleteNote(index);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return ['edit', 'delete'].map((String choice) {
                                    return PopupMenuItem<String>(value: choice,child: Text(choice),);
                                  }).toList();
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
              _loadingHolidays? Center(child: CircularProgressIndicator()): (_events.isEmpty? Center(child: Text('There are no holidays this month',style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.normal,),),)
                      : ListView.builder(itemCount: _events.length,itemBuilder: (context, index) {
                            final date = _events.keys.elementAt(index);
                            final event = _events[date]?[0];
                            return Card(child: ListTile(title: Text(event),subtitle: Text('Date: ${date.month}/${date.day}/${date.year}'),),);
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}
