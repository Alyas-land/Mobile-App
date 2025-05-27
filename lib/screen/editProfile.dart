import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:practice2/screen/profile.dart';
import '../globalVariables/init.dart';
import '../serverConfiguration/serverAddress.dart';
import '../session/sessionStatus.dart';
import '../screen/login.dart';
import '../screen/card.dart';
import '../screen/aboutUs.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confrimPasswordController = new TextEditingController();


  // Variable for get data from database
  String nameDB = '';
  String emailDB = '';
  String phoneNumberDB = '';
  String usernameDB = '';
  String profilePictureDB = '';

  // End variable for get data from database

  Future<void> EditProfileUser({name, phoneNumber, email, username, password, required BuildContext context}) async {
    Map<String, dynamic> updateData = {};
    if (nameController.text != nameDB) {
      updateData['name'] = nameController.text;
    }
    if (emailController.text != emailDB) {
      updateData['email'] = emailController.text;
    }
    if (phoneNumberController.text != phoneNumberDB) {
      updateData['phone_number'] = nameController.text;
    }
    if (usernameController.text != usernameDB) {
      updateData['username'] = nameController.text;
    }
    if (passwordController.text.isNotEmpty &&
        passwordController.text == confrimPasswordController.text) {
      updateData['password'] = passwordController.text;
    }

    if (updateData.isEmpty) {
      Flushbar(
        titleText: Text('*عملیات ناموفق*',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        messageText: Text('شما فیلدی را تغییر نداده اید!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        margin: EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(10),
        duration: Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,

      ).show(context);
      return;
    }
    final response = await http.post(
      Uri.parse('$server/api/user/info/edit/$globalUserId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updateData),
    );

    if (response.statusCode == 200){
      Flushbar(
        titleText: Text('*عملیات موفق*',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        messageText: Text('ویرایش اطلاعات با موفقیت انجام شد!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        margin: EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(10),
        duration: Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,

      ).show(context);

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
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
    }
    else {
      Flushbar(
        titleText: Text('*خطا در بروزرسانی اطلاعات*',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        messageText: Text('لطفا دوباره تلاش کنید!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        margin: EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(10),
        duration: Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,

      ).show(context);
    }
  }



  Future<void> getInfo(id) async {
    final response = await http.get(
      Uri.parse('$server/api/user/info/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    print('in future');

    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      setState(() {
        nameDB = data['name'];
        emailDB = data['email'];
        phoneNumberDB = data['phone_number'];
        usernameDB = data['username'];
        profilePictureDB = data['profile_path'];

        nameController.text = nameDB;
        emailController.text = emailDB;
        phoneNumberController.text = phoneNumberDB;
        usernameController.text = usernameDB;
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
            appBar: AppBar(
              title: Image.asset(
                'assets/img/new-logo-blue-edited-appbar.png',
                width: 90,),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Color(0xFF0A0E21),
              actions: [
                Builder(
                  builder: (context) =>
                      IconButton(
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
              leading: IconButton(
                icon: Icon(
                  LineAwesomeIcons.chevron_circle_left,
                  color: Color(0xFF5CE1E6),
                ),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                          ProfilePage(),
                      transitionsBuilder: (context,
                          animation,
                          secondaryAnimation,
                          child,) {
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
            ),

            endDrawer: MyDrawerMenu(),

            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                                '$server/$profilePictureDB',
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

                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red
                            ),
                            child: const Icon(LineAwesomeIcons.camera,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: const Text('نام و نام خانوادگی',
                                    style: TextStyle(
                                        color: Color(0xFF5CE1E6)
                                    ),),
                                ),

                                TextField(
                                  controller: nameController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFFCFF4FC)),
                                  // controller: name,
                                  decoration: InputDecoration(
                                    // errorText: errorUsername,
                                    hintText: nameDB,
                                    hintStyle: TextStyle(
                                        color: Color(0x705CE1E6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 2.0
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 1.5
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF5CE1E6), width: 1.5
                                      ),
                                    ),


                                    // fillColor: Color(0x3BFFFFFF),
                                    // filled: true,

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: const Text('ایمیل',
                                    style: TextStyle(
                                        color: Color(0xFF5CE1E6)
                                    ),),
                                ),

                                TextField(
                                  controller: emailController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFFCFF4FC)),
                                  // controller: name,
                                  decoration: InputDecoration(
                                    // errorText: errorUsername,
                                    hintText: emailDB,
                                    hintStyle: TextStyle(
                                        color: Color(0x705CE1E6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 2.0
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 1.5
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF5CE1E6), width: 1.5
                                      ),
                                    ),


                                    // fillColor: Color(0x3BFFFFFF),
                                    // filled: true,

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: const Text('شماره همراه',
                                    style: TextStyle(
                                        color: Color(0xFF5CE1E6)
                                    ),),
                                ),

                                TextField(
                                  controller: phoneNumberController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFFCFF4FC)),
                                  // controller: name,
                                  decoration: InputDecoration(
                                    // errorText: errorUsername,
                                    hintText: phoneNumberDB,
                                    hintStyle: TextStyle(
                                        color: Color(0x705CE1E6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 2.0
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 1.5
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF5CE1E6), width: 1.5
                                      ),
                                    ),


                                    // fillColor: Color(0x3BFFFFFF),
                                    // filled: true,

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: const Text('نام کاربری',
                                    style: TextStyle(
                                        color: Color(0xFF5CE1E6)
                                    ),),
                                ),

                                TextField(
                                  controller: usernameController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFFCFF4FC)),
                                  // controller: name,
                                  decoration: InputDecoration(
                                    // errorText: errorUsername,
                                    hintText: usernameDB,
                                    hintStyle: TextStyle(
                                        color: Color(0x705CE1E6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 2.0
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 1.5
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF5CE1E6), width: 1.5
                                      ),
                                    ),


                                    // fillColor: Color(0x3BFFFFFF),
                                    // filled: true,

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: const Text('رمز عبور',
                                    style: TextStyle(
                                        color: Color(0xFF5CE1E6)
                                    ),),
                                ),

                                TextField(
                                  obscureText: true,
                                  controller: passwordController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFFCFF4FC)),
                                  // controller: name,
                                  decoration: InputDecoration(
                                    // errorText: errorUsername,
                                    hintText: '****',
                                    hintStyle: TextStyle(
                                        color: Color(0x705CE1E6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 2.0
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 1.5
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF5CE1E6), width: 1.5
                                      ),
                                    ),


                                    // fillColor: Color(0x3BFFFFFF),
                                    // filled: true,

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: const Text('تکرار رمز عبور',
                                    style: TextStyle(
                                        color: Color(0xFF5CE1E6)
                                    ),),
                                ),

                                TextField(
                                  obscureText: true,
                                  controller: confrimPasswordController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Color(0xFFCFF4FC)),
                                  // controller: name,
                                  decoration: InputDecoration(
                                    // errorText: errorUsername,
                                    hintText: "****",
                                    hintStyle: TextStyle(
                                        color: Color(0x705CE1E6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 2.0
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0x705CE1E6), width: 1.5
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF5CE1E6), width: 1.5
                                      ),
                                    ),


                                    // fillColor: Color(0x3BFFFFFF),
                                    // filled: true,

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(50, 40, 50, 1),
                            child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    side: BorderSide(width: 2,
                                      color: Color(0xFF70BFFF),)
                                ),
                                color: Color(0xFF164A74),
                                child: Text("ویرایش اطلاعات",
                                  style: TextStyle(
                                      color: Color(0xFFD3FFDD)),),

                                onPressed: () {
                                   EditProfileUser(context: context);

                                }),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
            bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .endFloat,
            floatingActionButton: MyFloatingActionButton()

        ),
      ),
    );
  }
}


