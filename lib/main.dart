import 'package:chatapp_master/screens/patient/home.dart';
import 'package:chatapp_master/screens/pharmacy/home.dart';
import 'package:chatapp_master/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat contorllers/chathome_controller/chathome_cubit.dart';
import 'chat contorllers/chatpagecontroller/chatpage_cubit.dart';
import 'screens/main_screen.dart';
import 'package:chatapp_master/screens/patient/scan_prescription.dart';
import 'package:flutter/src/material/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  Constants.userid = sharedPref.getString('userID');
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDdRXrkocrXopW9UsseuvpYHzz7XMf5s84",
          appId: "chat-app-c886b",
          messagingSenderId: "messagingSenderId",
          projectId: "chat-app-c886b"));
  runApp(
    const MyHome(),
  );
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Courgette",
          primarySwatch: Colors.cyan,
        ),
        home: FirstScreen(),
      ),
    );
  }
}
