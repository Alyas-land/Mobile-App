import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:practice2/screen/basketHistory.dart';
import 'package:practice2/screen/editProfile.dart';
import '../globalVariables/init.dart';
import '../serverConfiguration/serverAddress.dart';
import '../session/sessionStatus.dart';
import '../screen/login.dart';
import '../screen/card.dart';
import '../screen/aboutUs.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';



class ProfilePage extends StatefulWidget {
  final userId;

  const ProfilePage({super.key, this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String profilePitcture = '';

  Future<void> getInfo(id) async{
    final response = await http.get(
      Uri.parse('$server/api/user/info/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    print('in future');

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200){
      print('yes');
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      setState(() {
        name = data['name'];
        email = data['email'];
        profilePitcture = data['profile_path'];
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF0C2D48),

            title: Text("خطا",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFFFF8B48)
              ),
            ),
            content: Text(data['msg'],
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Color(0xFFE16C6C)
              ),
            ),
            actions: [
              TextButton(
                child: Center(child: Text("بستن",
                  style: TextStyle(
                      color: Color(0xFF6CE183)
                  ),
                )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo(globalUserId);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Irancell"
      ),
      home: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0), // near the top right
            radius: 0.8,
            colors: <Color>[
              Color(0xFF1E295E), //  sun
              Color(0xFF0A0E21), //  sky
            ],
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Image.asset(
            'assets/img/new-logo-blue-edited-appbar.png',
            width: 90,),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Color(0xFF0A0E21),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ],
          ),

          endDrawer: MyDrawerMenu(),

        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.6),
                    blurRadius: 10,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: SizedBox(

                width: 120, height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network('$server/$profilePitcture',
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null)
                        return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },

                  )
                  ,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF5CE1E6)),
            ),
            const SizedBox(height: 5,),
            Text(
              email,
              style: TextStyle(
                fontFamily: 'CFN',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF5CE1E6)),
            ),

            const SizedBox(height: 20,),

            SizedBox(
              width: 210,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => EditProfilePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        );
                        return FadeTransition(
                          opacity: curvedAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 400),
                    ),
                  );

                },
                child: const Text('ویرایش پروفایل',
                style: TextStyle(color: Color(0xFF5CE1E6)),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF164A74),
                  side: BorderSide(
                    color: Color(0xFF5CE1E6),
                    width: 1
                  ),
                  shape: const StadiumBorder()),

              ),
            ),
            const SizedBox(height: 30,),
            const Divider(endIndent: 40,
            indent: 40, color: Color(0x915CE1E6),),
            const SizedBox(height: 10,),

            SizedBox(
              width: 320,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.heart, color: Color(0xFF5CE1E6),),
                      ),
                      title: Text('علاقه مندی ها',
                      style: TextStyle(
                        color: Color(0xFF5CE1E6),
                        fontSize: 12
                      ),),

                      trailing: Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.angle_left, color: Colors.white38,),
                      ),
                    ),

                    ListTile(
                      leading: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.bell, color: Color(0xFF5CE1E6)),
                      ),
                      title: Text('اعلان‌ها',
                        style: TextStyle(
                            color: Color(0xFF5CE1E6),
                            fontSize: 12
                        ),),

                      trailing: Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.angle_left, color: Colors.white38,),
                      ),


                    ),

                    ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => CardsHistory(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              final curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              );

                              return FadeTransition(
                                opacity: curvedAnimation,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      },

                      leading: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.history, color: Color(0xFF5CE1E6)),
                      ),
                      title: Text('سوابق فعالیت‌ها',
                        style: TextStyle(
                            color: Color(0xFF5CE1E6),
                            fontSize: 12
                        ),),


                      trailing: Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.angle_left, color: Colors.white38,),
                      ),


                    ),
                    const Divider(endIndent: 40,
                      indent: 40, color: Color(0x305CE1E6),),

                    ListTile(
                        leading: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(100),
                            color: Color(0xFF212C61),
                          ),
                          child: Icon(LineAwesomeIcons.cog, color: Color(0xFF5CE1E6)),
                        ),
                        title: Text('تنظیمات',

                          style: TextStyle(
                              color: Color(0xFF5CE1E6),
                              fontSize: 12,
                          ),),

                      
                        trailing: Container(
                          width: 30, height: 30,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(100),
                            color: Color(0x91212C61),
                          ),
                          child: Icon(LineAwesomeIcons.angle_left, color: Colors.white38,),
                        ),
                      
                      
                      ),


                    ListTile(
                      splashColor: Color(0x6E5CE1E6),
                      focusColor : Color(0x6E5CE1E6),
                      leading: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color: Color(0xFF212C61),
                        ),
                        child: Icon(LineAwesomeIcons.alternate_sign_out, color: Colors.red,),
                      ),
                      title: Text('خروج',
                      style: TextStyle(
                        color: Colors.red
                      ),),
                      onTap: (){
                        globalUserId = null;
                        // Route route = MaterialPageRoute(builder: (context) => LoginPage());
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              final curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              );

                              return FadeTransition(
                                opacity: curvedAnimation,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      },



                    ),
                  ],
                ),
              ),
            )



          ],
        ),
          bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: MyFloatingActionButton()

        ),
      ),
    );
  }
}



