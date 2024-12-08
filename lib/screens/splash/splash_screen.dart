import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/components/button_light_gray.dart';
import 'package:volunteer_community_connection_app/screens/account/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'SHARE - INSPIRE - CONNECT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 2,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ButtonLightGray(
                  des: 'GET STARTED',
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
