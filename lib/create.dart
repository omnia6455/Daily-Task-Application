import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'Task.dart';
import 'main.dart';
class Creation extends StatefulWidget {
 const Creation({super.key});
  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String? errorTitle;
  String? errorTask;
  int length = 1;
  List<TextEditingController> taskControllers = [TextEditingController()];
  TextEditingController titleController = TextEditingController();
  DateRangePickerController dateController = DateRangePickerController();
  void onTimeChanged(TimeOfDay newTime) {
    selectedTime = newTime;
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: const Color(0xffbe566b).withOpacity(.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * .06),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: screenSize.width * .25,
                  height: screenSize.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white24),
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white70,
                        size: 20,
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Text(
                          "Back",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                "Create Your Task",
                style: TextStyle(
                  color: Colors.black.withOpacity(.73),
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .02),
            Expanded(
              child: Container(
                width: screenSize.width,
                decoration: const BoxDecoration(
                    color: Color(0xfffbe4f2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child:
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        child: Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(.73)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(8),
                        width: screenSize.width,
                        height: screenSize.height * .26,
                        child: SfDateRangePicker(
                          controller: dateController,
                          selectionColor: Colors.black38,
                          selectionTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                          todayHighlightColor: Colors.yellow,
                          monthViewSettings:
                              const DateRangePickerMonthViewSettings(
                            firstDayOfWeek: 7,
                          ),
                          backgroundColor:
                              const Color(0xffbe566b).withOpacity(.6),
                          allowViewNavigation: true,
                          headerStyle: DateRangePickerHeaderStyle(
                              backgroundColor:
                                  const Color(0xffbe566b).withOpacity(.1),
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18),
                              textAlign: TextAlign.center),
                          showNavigationArrow: true,
                          navigationDirection:
                              DateRangePickerNavigationDirection.vertical,
                          navigationMode: DateRangePickerNavigationMode.snap,
                          selectionShape:
                              DateRangePickerSelectionShape.circle,
                          monthCellStyle: const DateRangePickerMonthCellStyle(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                            cellDecoration: BoxDecoration(
                                color: Color(0xfffbe4f2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            todayTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(.73)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: TimePicker(
                          onTimeChanged: onTimeChanged,
                          color: const Color(0xffbe566b).withOpacity(.6),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              "Task",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.black.withOpacity(.73),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 3.5, left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    length++;
                                    taskControllers.add(TextEditingController());
                                  });
                                },
                                child: Image.asset(
                                  "assets/image/add_icon.png",
                                  width: 30,
                                  height: 30,
                                  color: const Color(0xffbe566b).withOpacity(.99),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 3.5, left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (length > 1) {
                                    setState(() {
                                      length--;
                                      taskControllers.removeLast();
                                    });
                                  } else {
                                    SnackBar snackBar = const SnackBar(
                                      content: Text(
                                        "You must have at least one task!",
                                        style: TextStyle(
                                            color: Color(0xfffbe4f2),
                                            fontSize: 18,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      backgroundColor: Color(0xffbe566b),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Image.asset(
                                  "assets/image/minus.png",
                                  width: 25,
                                  height: 25,
                                  color: const Color(0xffbe566b).withOpacity(.99),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 8),
                            child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty) {
                                      errorTask = "Please Enter Your Task!";
                                    } else {
                                      errorTask = null;
                                    }
                                  });
                                },
                                textInputAction:TextInputAction.next ,
                                controller: taskControllers[index],
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xffbe566b)
                                              .withOpacity(.6)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: const Color(0xffbe566b)
                                                .withOpacity(.99))),
                                    hintText: "Write Your Task",
                                    helperStyle: const TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                    errorText:index==0?errorTask:null,
                                    errorStyle: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w800),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xffbe566b)
                                                .withOpacity(.6)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))))),
                          );
                        },
                        itemCount: length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 36),
                        child: Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(.73)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 36),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                errorTitle = "Please Enter Your Tile!";
                              } else {
                                errorTitle = null;
                              }
                            });
                          },
                          controller: titleController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xffbe566b)
                                        .withOpacity(.6)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: const Color(0xffbe566b)
                                          .withOpacity(.99))),
                              errorText: errorTitle,
                              errorStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                              hintText: "Write Your Title",
                              helperStyle: const TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffbe566b)
                                          .withOpacity(.6)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (titleController.text !=""&&taskControllers.first.text!="") {
              
                            Task task =Task(
                              id: Random().nextInt(5000),
                              quests:taskControllers.where((element) => element.text.isNotEmpty,).map((e) => Quest(title: e.text, done: false),).toList() ,
                              title:titleController.text,
                              date: dateController.selectedDate?? DateTime.now(),
                              time: selectedTime.format(context),
                              save:false,
                              fav:false,
                            );
                            await database.insert('task',task.toMap());
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              errorTask = "Please Enter Your Task!";
                              errorTitle = "Please Enter Your Title!";
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xffbe566b),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      const Color(0xfffbe4f2).withOpacity(.9),
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
          ],
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeChanged;
 final Color color;
  const TimePicker({
    Key? key,
    required this.onTimeChanged,required this.color
  }) : super(key: key);
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;
  void iniState() {}
  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime!,
            );
            if (pickedTime != null) {
              setState(() {
                selectedTime = pickedTime;
                widget.onTimeChanged(pickedTime);
              });
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.color),
          child: Text(
            "Select Time",
            style: TextStyle(
                color: const Color(0xfffbe4f2).withOpacity(.9),
                fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(width: 12,),
        Container(
          width: 135,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: widget.color,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              selectedTime != null
                  ? selectedTime!.format(context)
                  : "No time Selected",
              style: TextStyle(
                color: const Color(0xfffbe4f2).withOpacity(.9),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
