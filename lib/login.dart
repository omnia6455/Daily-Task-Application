import 'dart:math';
import 'package:agenda/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String? errorText;
  bool textForm = false;
  @override
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
            children: [
      ClipPath(
        clipper: MyClipper(),
        child: Container(
          color: const Color(0xffc06a7b),
        ),
      ),
      Positioned(
        top: -36,
        left: -36,
        child: Transform.rotate(
          angle: pi / 12,
          child: ClipPath(
            clipper: MyClipper2(),
            child: Container(
              width: 300,
              height: 150,
              color: Colors.white.withOpacity(.1),
            ),
          ),
        ),
      ),
      Positioned(
        top: screenSize.height * .53,
        right: -screenSize.width * .15,
        child: Transform.rotate(
          angle: pi / 9,
          child: ClipPath(
            clipper: MyClipper2(),
            child: Container(
              width: 250,
              height: 110,
              color: Colors.white.withOpacity(.1),
            ),
          ),
        ),
      ),
      Positioned(
          left: 20,
          right: 20,
          bottom: screenSize.height * .575,
          child: Image.asset("assets/image/onboarding.png")),
      Positioned(
              top: screenSize.height * .56,
              left: 12,
              right: 12,
              bottom: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "ENTER\n YOUR NAME",
                      style: TextStyle(
                        color: Color(0xffda7286),
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * .08,
                    ),
                    TextFormField(
                      textInputAction:TextInputAction.next ,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            errorText = "Please Enter At Least Your First Name!";
                          } else {
                            errorText = null;
                          }
                        });
                      },
                      controller: firstNameController,
                      decoration: InputDecoration(
                        errorText: errorText,
                        errorStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffbe566b),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xffbe566b),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xffbe566b),
                            )),
                        hintText: ' First Name',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * .01,
                    ),
                    TextFormField(
                      textInputAction:TextInputAction.done,
                      controller: lastNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffbe566b),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xffbe566b),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xffbe566b),
                            )),
                        hintText: ' Last Name (optional)',
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * .08,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (firstNameController.text != "") {
                          await prefs.setString('Name', '${firstNameController.text} ${lastNameController.text}');
                          await flutterLocalNotificationsPlugin.show(
                            Random().nextInt(5000),
                            'Hello, ${prefs.getString('Name')}',
                            'This app is for daily tasking wish you enjoy it!',
                            const NotificationDetails(
                              android: AndroidNotificationDetails(
                                  'notificationChannelID', 'Agenda Channel',
                                  importance: Importance.max,
                                  playSound: true,
                                  priority: Priority.high),
                            ),
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const HomeScreen();
                            },
                          ));
                        } else {
                          setState(() {
                            errorText = "Please Enter At Least Your First Name!";
                          });
                        }
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color(0xffbe566b).withOpacity(.5),
                                    blurRadius: 8.0)
                              ],
                              color: const Color(0xffbe566b),
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFf2d3d8), Color(0xffbe566b)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                          width: 65,
                          height: 65,
                          child: Image.asset("assets/image/arrow.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ]));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, size.height * 0.7);
    path.cubicTo(size.width * .25, size.height * .6, size.width * .4,
        size.height * .5, 0, size.height * .45);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCenter(
        center: Offset(size.width * .5, size.height * .5),
        width: size.width,
        height: size.height));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
