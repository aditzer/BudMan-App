import 'package:budman_app/pages/DashBoard.dart';
import 'package:budman_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/Authentication.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int page=0;
  Future<bool> load() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? userPref = userData.getString('token');
    if(userPref==null){
      return false;
    }
    else{
      page=1;
      await Authentication.refreshUser();
      return true;
    }
  }
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: load(),
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          return GetMaterialApp(
            theme: ThemeData(
              textTheme: GoogleFonts.publicSansTextTheme(Theme.of(context).textTheme,),
            ),
            debugShowCheckedModeBanner: false,
            home: page==1 ? DashBoardPage():LoginPage(),
          );
        }
        else{
          return const Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              )
          );
        }
      },
    );
  }
}
