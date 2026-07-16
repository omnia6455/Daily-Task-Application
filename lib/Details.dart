import 'dart:ui';
import 'package:agenda/create.dart';
import 'package:agenda/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'Task.dart';

class Details extends StatefulWidget {
  final Task task;
  final Color color;
  const Details({super.key, required this.task, required this.color});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DateRangePickerController dateController = DateRangePickerController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      selectedTime = newTime;
      widget.task.time = selectedTime.format(context);
    });
  }

  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      widget.task.date = selectedDate;
    });
  }

  Quest? deletedTask;
  int? deletedIndex;
  bool add = false;
  bool editTitle = false;
  bool editTime = false;
  bool editDate = false;
  bool editTask = false;
  List<TextEditingController> textEditingControllers = [];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              "assets/image/background_details.png",
              fit: BoxFit.cover,
            )),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
                child: Container(
                  color: Colors.black.withOpacity(.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: screenSize.height * .05,
                  width: screenSize.width * .25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white70),
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: widget.color.withOpacity(.9),
                        size: 20,
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: widget.color.withOpacity(.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * .12,
              right: 20,
              left: 20,
              child: Container(
                height: screenSize.height * .06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white70),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Details",
                    style: TextStyle(
                        color: widget.color.withOpacity(.9),
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      fontFamily: "sofadiOne"
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * .2,
              bottom: 0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height ,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white70),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24,vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Title:",
                              style: TextStyle(
                                color: widget.color.withOpacity(.9),
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: editTitle
                                  ? TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          widget.task.title = value;
                                        });
                                      },
                                      initialValue: widget.task.title,
                                      style: TextStyle(
                                        color:widget.color,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                            color: widget.color
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                            color: widget.color
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                    child: Text(
                                        widget.task.title,
                                        style: TextStyle(
                                          color: widget.color.withOpacity(.7),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                  ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Row(
                          children: [
                            Text(
                              "Date:",
                              style: TextStyle(
                                  color: widget.color.withOpacity(.9),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: editDate
                                  ? SfDateRangePicker(
                                      onSelectionChanged:
                                          (dateRangePickerSelectionChangedArgs) {
                                        onDateChanged(
                                            dateRangePickerSelectionChangedArgs
                                                .value);
                                      },
                                      controller: dateController,
                                      selectionColor: Colors.black38,
                                      selectionTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                      monthViewSettings:
                                          const DateRangePickerMonthViewSettings(
                                        firstDayOfWeek: 7,
                                      ),
                                      backgroundColor: widget.color,
                                      allowViewNavigation: true,
                                      headerStyle:
                                          DateRangePickerHeaderStyle(
                                              backgroundColor: widget.color
                                                  .withOpacity(.1),
                                              textStyle:
                                                  const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 18),
                                              textAlign: TextAlign.center),
                                      showNavigationArrow: true,
                                      navigationDirection:
                                          DateRangePickerNavigationDirection
                                              .vertical,
                                      navigationMode:
                                          DateRangePickerNavigationMode
                                              .snap,
                                      selectionShape:
                                          DateRangePickerSelectionShape
                                              .circle,
                                      monthCellStyle:
                                          const DateRangePickerMonthCellStyle(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                        cellDecoration: BoxDecoration(
                                            color: Color(0xfffbe4f2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        todayTextStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      DateFormat.MEd().format(widget.task.date),
                                      style: TextStyle(
                                        color: widget.color.withOpacity(.7),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * .05),
                        Row(
                          children: [
                            Text(
                              "Time:",
                              style: TextStyle(
                                  color: widget.color,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900),
                            ),
                            editTime
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: 12),
                                    child: TimePicker(
                                      onTimeChanged: onTimeChanged,
                                      color: widget.color,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.task.time,
                                      style: TextStyle(
                                        color: widget.color.withOpacity(.7),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                         SizedBox(
                          height: screenSize.height * .05,
                         ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Task:",
                            style: TextStyle(
                                color: widget.color.withOpacity(.9),
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(height: 16,),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.task.quests.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/image/dot_icon.png",
                                  color: widget.color,
                                  width: 30,
                                  height: 30,
                                ),
                                editTask
                                    ? Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            widget.task.quests[index]
                                                .title = value;
                                          },
                                          initialValue:
                                              widget.task.quests[index].title,
                                          style: TextStyle(
                                            color:widget.color,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                color: widget.color
                                              ),
                                            ),
                                            enabledBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                color:widget.color
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                      child: Text(
                                          widget.task.quests[index].title,
                                          style: TextStyle(
                                              color: widget.color
                                                  .withOpacity(.7),
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                              widget.task.quests[index].done == true
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              decorationColor: widget.color,
                                              decorationThickness: 2),
                                        ),
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3.5, left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (widget.task.quests.length > 1) {
                                        setState(() {
                                          deletedTask = widget.task.quests
                                              .removeAt(index);
                                          deletedIndex = index;
                                          update(widget.task);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${deletedTask!.title} has been deleted!",
                                                style: const TextStyle(
                                                    color:
                                                        Color(0xfffbe4f2),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .hideCurrentSnackBar();
                                                  setState(() {
                                                    widget.task.quests
                                                        .insert(
                                                            deletedIndex!,
                                                            deletedTask!);
                                                    deletedTask = null;
                                                    deletedIndex = null;
                                                    // update(widget.task);
                                                  });
                                                },
                                                child: const Text(
                                                  "UNDO",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xfffbe4f2),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      decoration:
                                                          TextDecoration
                                                              .underline,
                                                      decorationColor:
                                                          Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: widget.color,
                                        ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "You must have at least one task!",
                                              style: TextStyle(
                                                  color: Color(0xfffbe4f2),
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                            backgroundColor: widget.color,
                                          ),
                                        );
                                      }
                                    },
                                    child: editTask?Image.asset(
                                      "assets/image/minus.png",
                                      width: 25,
                                      height: 25,
                                      color: widget.color.withOpacity(.99),
                                    ):const SizedBox(),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.task.quests[index].done =
                                          !widget.task.quests[index].done;
                                      // update(widget.task);
                                    });
                                  },
                                  child: editTask? const SizedBox():
                                  widget.task.quests[index].done ?
                                  Image.asset(
                                          "assets/image/done_task_fill.png",
                                          width: 35,
                                          height: 35,
                                          color: widget.color,
                                        )
                                      : Image.asset(
                                          "assets/image/done_task.png",
                                          width: 35,
                                          height: 35,
                                          color: widget.color,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Row(
                            children: [
                              Image.asset(
                                "assets/image/dot_icon.png",
                                color: widget.color,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: textEditingControllers[index],
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xffbe566b)
                                              .withOpacity(.6)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: const Color(0xffbe566b)
                                                .withOpacity(.99))),
                                    hintText: "Write Your Task",
                                    hintStyle: TextStyle(
                                      color: widget.color,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xffbe566b)
                                              .withOpacity(.6)),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 3.5, left: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      textEditingControllers.removeAt(index);
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/image/cancel_text.png",
                                    width: 40,
                                    height: 40,
                                    color: widget.color.withOpacity(.99),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 3.5, left: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(textEditingControllers[index].text.isNotEmpty){
                                        widget.task.quests.add(Quest(
                                            title: textEditingControllers[index].text,
                                            done: false),);
                                      }
                                      textEditingControllers.removeAt(index);
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/image/done_text.png",
                                    width: 40,
                                    height: 40,
                                    color: widget.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          itemCount: textEditingControllers.length,
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 36),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textEditingControllers
                                        .add(TextEditingController());
                                  });
                                },
                                child: Image.asset(
                                  "assets/image/add_icon.png",
                                  width: 30,
                                  height: 30,
                                  color: widget.color.withOpacity(.99),
                                ),
                              ),
                            ),
                            Text(
                              "Add Task",
                              style: TextStyle(
                                  color: widget.color.withOpacity(.7),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: screenSize.width * .3,
                              height: screenSize.height * .08,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editTask = !editTask;
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/image/edit.png",
                                    color: Colors.white70,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenSize.width * .23),
                            Container(
                              width: screenSize.width * .3,
                              height: screenSize.height * .08,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editTitle = !editTitle;
                                      // update(widget.task);
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/image/edit_title.png",
                                    color: Colors.white70,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * .1,
                        ),
                        Row(
                          children: [
                            Container(
                              width: screenSize.width * .3,
                              height: screenSize.height * .08,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editDate = !editDate;
                                      // update(widget.task);
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/image/edit_date.png",
                                    color: Colors.white70,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenSize.width * .23),
                            Container(
                              width: screenSize.width * .3,
                              height: screenSize.height * .08,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editTime = !editTime;
                                      // update(widget.task);
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/image/edit_time.png",
                                    color: Colors.white70,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * .1,
                        ),
                        // Spacer(),
                        Center(
                          child: Container(
                            width: screenSize.width * .4,
                            height: screenSize.height * .08,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  update(widget.task);
                                  Navigator.pop(context);
                                });
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  child: Text(
                                    "Save Changes",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.none,
                                      color: const Color(0xfffbe4f2).withOpacity(.9),
                                      fontFamily: "sofadiOne"
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void update(Task task) {
    database
        .update('task', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}
