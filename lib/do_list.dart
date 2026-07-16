import 'dart:convert';
import 'package:agenda/Settings.dart';
import 'package:agenda/list.dart';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'main.dart';
class DoList extends StatefulWidget {
const DoList({super.key,});
  @override
  State<DoList> createState() => _DoListState();
}

class _DoListState extends State<DoList> {
  int index = 0;
  int page = 0;
  bool next = true;
  List<Task> tasks = [];
  void getData() async {
    tasks = (await database.query('task')).map(
      (e) {
        return Task(
            id: e['id'] as int,
            quests: (List<Map<String, dynamic>>.from(
                    json.decode(e['task'] as String) as List<dynamic>))
                .map(
                  (e) => Quest.fromMap(e),
                )
                .toList(),
            title: e['title'] as String,
            time: e['time'] as String,
            date: DateTime.parse(e['date'] as String),
            save: e['save'] as int == 1 ? true : false,
            fav: e['fav'] as int == 1 ? true : false);
      },
    ).toList().where((element) {
      String period = element.time.split(' ')[1];
      int hour = int.parse(element.time.split(':')[0])  + ( period == 'PM' ? 12 : 0);
      int minute = int.parse(element.time.split(':')[1].split(' ')[0]);
      DateTime taskDate = DateTime(element.date.year,  element.date.month , element.date.day ,hour , minute);
      return taskDate.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    tasks.sort(
      (a, b) => a.date.millisecondsSinceEpoch - b.date.millisecondsSinceEpoch,
    );
    getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbe566b).withOpacity(.6),
        leadingWidth: screenSize.width * .2,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Settings();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                "assets/image/settings.png",
                color: const Color(0xfffbe4f2),
              ),
            ),
          )
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Hello,\n ${prefs.getString('Name')}",
            style: const TextStyle(
              color: Color(0xfffbe4f2),
              fontWeight: FontWeight.w900,
              fontSize: 24,
              fontFamily: "sofadiOne",
            ),
          ),
        ),
      ),
      body:Container(
        clipBehavior: Clip.none,
        color: const Color(0xffbe566b).withOpacity(.6),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12),
                  child: Text(
                    "Daily Task",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.73),
                        fontSize: 26,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(
                  height: 22,),
                Expanded(
                  child: Container(
                      width: screenSize.width,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                        color: Color(0xfffbe4f2),
                      ),
                      child: tasks.isEmpty
                          ? Center(
                            child: Text(
                              "No Tasks Created Yet!",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xffbe566b).withOpacity(.4),
                              ),
                            ),
                          ) :
                      TasksList(tasks:tasks,)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

