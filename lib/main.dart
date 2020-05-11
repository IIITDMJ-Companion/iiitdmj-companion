import 'package:flutter/material.dart';
import 'package:iiitdmjcompanion/screens/home_screen.dart';
import 'package:iiitdmjcompanion/services/storage_service.dart';

//Use Future builder to access database to access app database
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff24252A),
        backgroundColor: Color(0xff24252A),
        fontFamily: 'code-bold',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getInstance(),
      builder: (context, AsyncSnapshot<StorageService> snapshot) {
        if (snapshot.hasError) {
          print('error');
          return Center(child: CircularProgressIndicator());
        } else {
          try {
            if (snapshot.data.userInDB == null) {
              print('new user');
              return UserSignUp(
                title: 'User Sign Up',
              );
            } else {
              //TODO: Implement User Logged In Home
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data.userInDB.name),
                    OutlineButton(
                        color: Colors.white,
                        child: Text('asda'),
                        onPressed: () {
                          setState(() {
                            snapshot.data.deleteKey(StorageService.UserKey);
                          });
                        }),
                  ],
                ),
              );
            }
          } catch (e) {
            print('Error: $e');
            return UserSignUp(
              title: 'User Sign Up',
            );
          }
        }
      },
    );
  }
}
