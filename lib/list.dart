import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Details.dart';
import 'Task.dart';
import 'main.dart';
class TasksList extends StatefulWidget {
   final List<Task>tasks;
   const TasksList({super.key,required this.tasks});

  @override
  State<TasksList> createState() => _TasksListState();
}
class _TasksListState extends State<TasksList> {
  List<Color> colors = [
    const Color(0xffd364cf),
    const Color(0xffd36464),
    const Color(0xff64a5d3),
    const Color(0xffff9f74),
    const Color(0xffff95b7),
  ];
  List<Task> deletedTask=[];
  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    return  ListView.separated(
      padding: EdgeInsets.only(
          bottom: kBottomNavigationBarHeight * 2,
          top: screenSize.height * .05
      ),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            width: screenSize.height * .1,
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                "-------",
                style: TextStyle(
                  color: colors[index % colors.length],
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        );
      },
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: screenSize.height * .2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    clipBehavior: Clip.none,
                    height: screenSize.height * .09,
                    decoration: BoxDecoration(
                        color:
                        colors[index % colors.length],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colors[
                            index % colors.length],
                            blurRadius: 24,
                            offset: const Offset(12, 0),
                          )
                        ]),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        task.title,
                        style: const TextStyle(
                            color: Color(0xfffbe4f2),
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontFamily: "dancing"
                        ),
                      ),
                    ),
                  ),
                ),
               SizedBox(width: 16,),
                Expanded(
                  child: Container(
                    height: screenSize.height * .19,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: colors[index % colors.length]
                            .withOpacity(.4),
                        borderRadius:
                        BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          color:
                          colors[index % colors.length],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              scrollDirection:
                              Axis.vertical,
                              physics:
                              const BouncingScrollPhysics(),
                              child: Column(
                              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) {
                                                  return Details(
                                                    task: task,
                                                    color: colors[
                                                    index %
                                                        colors.length],
                                                  );
                                                },
                                              ));
                                        },
                                        child: Image.asset(
                                          "assets/image/details.png",
                                          width: 40,
                                          height: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            task.save=!task.save;
                                            update(task);
                                          });
                                        },
                                        child:task.save?
                                        Image.asset(
                                            "assets/image/saved_fill.png",
                                            width: 40,
                                            height: 40,
                                            color:colors[index%colors.length]
                                        ):
                                        Image.asset(
                                            "assets/image/saved.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white54),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          task.fav=!task.fav;
                                          update(task);
                                        },
                                        child:task.fav?
                                        Image.asset(
                                            "assets/image/favourite_fill.png",
                                            width: 40,
                                            height: 40,
                                            color: colors[index%colors.length]):
                                        Image.asset(
                                            "assets/image/favourite.png",
                                            width: 40,
                                            height: 40,
                                            color: Colors.white70),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            deletedTask.add( widget.tasks.removeAt(index));
                                            database.delete(
                                                'task',
                                                where:
                                                'id = ?',
                                                whereArgs: [
                                                  deletedTask.last.id
                                                ]);
                                          });
                                          ScaffoldMessenger
                                              .of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Task has been deleted!",
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xfffbe4f2),
                                                        fontSize:
                                                        18,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (deletedTask
                                                          .isNotEmpty) {
                                                        await database.insert(
                                                            'task',
                                                            deletedTask.last
                                                                .toMap());
                                                        deletedTask.removeLast();
                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                      }
                                                    },
                                                    child:
                                                    const Text(
                                                      "UNDO",
                                                      style: TextStyle(
                                                          color: Color(0xfffbe4f2),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w900,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor:
                                              colors[index %
                                                  colors
                                                      .length],
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                            "assets/image/delete_task.png",
                                            width: 35,
                                            height: 35,
                                            color: Colors
                                                .white54),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment:
                                    Alignment.topLeft,
                                    child: Text(
                                      DateFormat.MEd()
                                          .format(
                                          task.date),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.w900,
                                        color: colors[index %
                                            colors.length],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .access_time_rounded,
                                        color: colors[index %
                                            colors.length],
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        task.time,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight
                                              .w900,
                                          color: colors[index %
                                              colors
                                                  .length],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount:
                                    task.quests.length,
                                    itemBuilder:
                                        (context, index) {
                                      return Opacity(
                                        opacity: task
                                            .quests[
                                        index]
                                            .done
                                            ? .5
                                            : 1.0,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/image/dot_icon.png",
                                              color: Colors
                                                  .white,
                                              width: 30,
                                              height: 30,
                                            ),
                                            Expanded(
                                              child: Text(
                                                task.quests[index].title,
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.w900,
                                                    decoration: task.quests[index].done
                                                        ? TextDecoration
                                                        .lineThrough
                                                        : TextDecoration
                                                        .none,
                                                    decorationColor:
                                                    Colors
                                                        .white,
                                                    decorationThickness:
                                                    2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: widget.tasks.length,
      shrinkWrap: true,
    );
  }
}
void update(Task task) {
  database
      .update('task', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
}
