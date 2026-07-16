import 'package:agenda/home.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'login.dart';
import 'main.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Permission.notification.request();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/image/welcome.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image.asset(
                "assets/image/word_welcome.png",
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height *.1,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) {
                    if (prefs.getString('Name') != null) {
                      return const HomeScreen();
                    }
                    else {
                      return const Login();
                    }
                  }));
                },
                child: Container(
                  width:65,
                  height:65,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),
                    color:const Color(0xFFf2d3d8)
                  ),
                  child: const Icon(Icons.arrow_forward_ios,color:Colors.white,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
