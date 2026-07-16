import 'dart:convert';

class Task {
  final List<Quest> quests;
   String title;
   String time;
   DateTime date;
   bool save;
   bool fav;
  final int id;
  Task(
      {required this.save,required this.fav,required this.id, required this.quests, required this.title, required this.time, required this.date});

  Map<String,dynamic>toMap()=> {
    'id': id,
    'task':json.encode(quests.map((e) => e.toMap()).toList()),
    'title':title,
    'time':time,
    'date':date.toString(),
    'save':save?1:0,
    'fav':fav?1:0
  };
}

class Quest{
  String title;
  bool done;
  Quest({required this.title, required this.done});


  Map<String,dynamic>toMap()=> {
    'title': title,
    'done': done,
  };

  static Quest fromMap(Map<String,dynamic> map) => Quest(title: map['title'] as String, done: map['done'] as bool);
}