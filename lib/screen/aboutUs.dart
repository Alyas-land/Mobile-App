import 'package:flutter/material.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';



class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});




  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  Widget _buildProfileImage(String path) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          path,
          width: 120,
          height: 130,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  bool _isPersian = true;

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
                )
            ),

            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(title: Image.asset(
                'assets/img/new-logo-blue-edited-appbar.png',
                width: 90,),

                // Center
                //   (child: Text("هکس آرنا",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 30,
                //       fontWeight: FontWeight.bold
                //   ),
                // ),
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


    body: Container(
    color: Color(0xFF0A0E21),
    padding: EdgeInsets.all(12),
    child: SingleChildScrollView(
    child: Column(
    children: [

    Container(

    decoration: BoxDecoration(
    color: Color(0xFF111427),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.5),
    blurRadius: 12,
    offset: Offset(0, 6),
    ),
    ],
    ),
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [



    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    _buildProfileImage('assets/img/alyas.png'),
    SizedBox(width: 30),
    _buildProfileImage('assets/img/javad.png'),
    ],
    ),

    SizedBox(height: 20),



    Text(_isPersian ? 'درباره ما' :
    'About Us',
    style: TextStyle(
      color: Colors.white38,
      fontWeight: FontWeight.bold
    ),),

      Divider(color: Colors.white24, height: 30, thickness: 1),


    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: _isPersian ? Text('''ما، علی مشایخی و محمدجواد صادقی، دانشجویان رشته مهندسی کامپیوتر هستیم که در راستای پروژه درس برنامه‌نویسی دستگاهی اقدام به طراحی و توسعه یک اپلیکیشن موبایل با استفاده از فریم‌ورک Flutter نمودیم.
این اپلیکیشن یک فروشگاه بازی‌های ویدیویی را شبیه‌سازی می‌کند که در آن کاربران می‌توانند به مرور و مشاهده اطلاعات انواع بازی‌ها بپردازند. هدف ما از این پروژه، پیاده‌سازی یک رابط کاربری روان، تجربه کاربری مناسب و آشنایی بیشتر با ساختار توسعه اپلیکیشن‌های موبایل چندسکویی بوده است.
این پروژه، تجربه‌ای ارزشمند در حوزه کار تیمی و توسعه نرم‌افزار برای ما رقم زد و گامی مؤثر در مسیر حرفه‌ای ما در دنیای فناوری اطلاعات به‌شمار می‌آید.'''
        ,
    style: TextStyle(
    color: Color(0xFF81B5D3),
    fontSize: 13,
    height: 1.6,
      fontWeight: FontWeight.bold,
      fontFamily: 'Dirooz'
    ),
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.justify,
    )
      :
      Text('''We are Ali Mashayekhi and Mohammadjavad Sadeghi, computer engineering students who developed a mobile application using the Flutter framework as part of our coursework for the Embedded Programming course.
Our application simulates a video game store, allowing users to browse and explore information about various video games. The main goal of this project was to design a smooth and user-friendly interface while gaining practical experience in cross-platform mobile development.
This project provided us with valuable insights into teamwork and software development and served as an important step in our journey into the tech industry.''',
        style: TextStyle(
          color: Color(0xFF81B5D3),
          fontSize: 14,
          height: 1.6,
          fontFamily: 'CFN'
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.justify,
      ),
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("EN",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold),
          ),
          Switch(
            inactiveThumbColor: Colors.blue,
            hoverColor: Colors.blue,
            activeColor: Colors.blue,
            value: _isPersian,
            onChanged: (value) {
              setState(() {
                _isPersian = value;
              });
            },
          ),
          Text("FA",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
    ),

    ),

    ],
    ),
    ),
    ),

    bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: MyFloatingActionButton()
            ))
    );
  }
}

