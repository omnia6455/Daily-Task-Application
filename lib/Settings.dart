import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:agenda/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool editName = false;
  bool language = false;
  bool notify=false;
  @override
  void initState() {
    super.initState();
    initNotify();
  }
  void initNotify()async{
    notify = prefs.getBool('notification')?? await Permission.notification.request().isGranted;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/image/background_setting.jpg",
            fit: BoxFit.cover,
          )),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                color: Colors.black.withOpacity(.3),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 48,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: screenSize.height * .05,
                width: screenSize.width * .27,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white54),
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xffbe566b).withOpacity(.9),
                      size: 20,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(
                        color: Color(0xffbe566b).withOpacity(.7),
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
                  color: Colors.white54),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Settings",
                  style: TextStyle(
                      color: Color(0xffbe566b).withOpacity(.9),
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      fontFamily: "sofadiOne"),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * .2,
            bottom: 0,
            child: Container(
              width: screenSize.width,
              height: screenSize.height * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white54),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * .1, horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name:",
                              style: TextStyle(
                                  color: Color(0xffbe566b).withOpacity(.9),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: editName
                                    ? TextFormField(
                                        onChanged: (value) {
                                          prefs.setString('Name', value);
                                        },
                                        initialValue:
                                            "${prefs.getString('Name')}",
                                        style: TextStyle(
                                            color: Color(0xffbe566b)
                                                .withOpacity(.75),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30,
                                            fontFamily: "sofadiOne"),
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
                                              color: Color(0xffbe566b)
                                                  .withOpacity(.9),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                              color: Color(0xffbe566b)
                                                  .withOpacity(.9),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        prefs.getString('Name')!,
                                        style: TextStyle(
                                          color: Color(0xffbe566b)
                                              .withOpacity(.75),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30,
                                        ),
                                      )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: screenSize.width * .2,
                                height: screenSize.height * .05,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: editName
                                      ? Color(0xffbe566b).withOpacity(.9)
                                      : Colors.white70,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        editName = true;
                                      });
                                    },
                                    child: Image.asset(
                                      "assets/image/edit_name.png",
                                      color: editName
                                          ? Colors.white
                                          : Color(0xffbe566b).withOpacity(.9),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: screenSize.width * .2,
                                height: screenSize.height * .05,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: editName
                                      ? Colors.white
                                      : Color(0xffbe566b).withOpacity(.9),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        editName = false;
                                      });
                                    },
                                    child: Image.asset(
                                      "assets/image/done_name.png",
                                      color: editName
                                          ? Color(0xffbe566b).withOpacity(.9)
                                          : Colors.white,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * .07),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Notification",
                              style: TextStyle(
                                  color: Color(0xffbe566b).withOpacity(.9),
                                  fontSize: 33,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          SizedBox(width: screenSize.width * .1),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: screenSize.width * .2,
                                height: screenSize.height * .05,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color:notify
                                      ? Color(0xffbe566b).withOpacity(.9)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: ()async{
                                      if (!await Permission.notification.request().isDenied) {
                                        setState(() {
                                          notify=!notify;
                                          prefs.setBool('notification', notify);
                                        });
                                      }
                                    },
                                    child: notify
                                        ? Image.asset(
                                            "assets/image/notification.png",
                                            color: Colors.white,
                                            width: 50,
                                            height: 50,
                                          )
                                        : Image.asset(
                                            "assets/image/notification_off.png",
                                            color: Color(0xffbe566b)
                                                .withOpacity(.9),
                                            width: 50,
                                            height: 50,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * .07),
                      // Row(
                      //   children: [
                      //     Align(
                      //       alignment: Alignment.topLeft,
                      //       child: Text(
                      //         "Language",
                      //         style: TextStyle(
                      //             color: Color(0xffbe566b).withOpacity(.9),
                      //             fontSize: 35,
                      //             fontWeight: FontWeight.w900,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //     SizedBox(width: screenSize.width * .16),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(vertical: 24),
                      //       child: Align(
                      //         alignment: Alignment.topRight,
                      //         child: Container(
                      //           width: screenSize.width * .2,
                      //           height: screenSize.height * .05,
                      //           padding: const EdgeInsets.all(5),
                      //           decoration: BoxDecoration(
                      //             color: language
                      //                 ? Color(0xffbe566b).withOpacity(.9)
                      //                 : Colors.white,
                      //             borderRadius: BorderRadius.circular(40),
                      //           ),
                      //           child: Align(
                      //             alignment: Alignment.center,
                      //             child: GestureDetector(
                      //                 onTap: () {
                      //                   setState(() {
                      //                     language = !language;
                      //                     prefs.setBool('language', language);
                      //                   });
                      //                 },
                      //                 child: language
                      //                     ? Image.asset(
                      //                         "assets/image/arabic.png",
                      //                         color: Colors.white,
                      //                         width: 50,
                      //                         height: 50,
                      //                       )
                      //                     : Image.asset(
                      //                         "assets/image/english.png",
                      //                         color: Color(0xffbe566b)
                      //                             .withOpacity(.9),
                      //                         width: 50,
                      //                         height: 50,
                      //                       )),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
