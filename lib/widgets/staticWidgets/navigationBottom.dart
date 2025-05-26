import 'package:flutter/material.dart';
import 'package:practice2/globalVariables/init.dart';
import 'package:practice2/main.dart';
import '../../screen/cardNotActive.dart';
import '../../screen/editProfile.dart';
import '../../screen/login.dart';
import '../../screen/infoAccount.dart';
import '../../session/sessionStatus.dart';
import '../../screen/productsPage.dart';
import '../../screen/card.dart';
import '../../globalVariables/init.dart';
import '../../screen/aboutUs.dart';
import '../../screen/profile.dart';
import '../../screen/basketHistory.dart';
import '../../screen/category.dart';
import '../../screen/profile.dart';
import '../../screen/registerWithProfile.dart';






class MyNavigationBottomBar extends StatefulWidget {
  final int InitializeIndex;

  const MyNavigationBottomBar({super.key, this.InitializeIndex=0});
  @override
  State<MyNavigationBottomBar> createState() => _MyNavigationBottomBarState();
}

class _MyNavigationBottomBarState extends State<MyNavigationBottomBar> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.InitializeIndex;
  }


  _onItemTapped(index){
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0){
      setState(() {
        indexDrawerSaver = null;
      });
      _selectedIndex = 0;
      if (globalUserId != null){
        print('if ');

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
            transitionDuration: Duration(milliseconds: 1000),
          ),
        );
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) => InfoAcountPage(userId: globalUserId),
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       final tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
        //       final curveTween = CurveTween(curve: Curves.ease);
        //
        //       return SlideTransition(
        //         position: animation.drive(curveTween).drive(tween),
        //         child: child,
        //       );
        //     },
        //   ),
        // );
      }
      else {
        print('else');
        Navigator.push(
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
            transitionDuration: Duration(milliseconds: 1000),
          ),
        );

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => LoginPage())
        // );


      }

    }

    if (index == 1){
      setState(() {
        indexDrawerSaver = null;
      });
      _selectedIndex = 1;
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => CategoryPage(),
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
          transitionDuration: Duration(milliseconds: 1000),
        ),
      );
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ProductsPage())
      // );
      setState(() {
        _selectedIndex = 1;
        indexDrawerSaver = null;
      });
    };

    if (index == 2){
      setState(() {
        indexDrawerSaver = 2;
      });
      _selectedIndex = 2;
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BasketPage(),
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
          transitionDuration: Duration(milliseconds: 1000),
        ),
      );
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => BasketPage())
      // );
    };

  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF0A0E21),
      selectedItemColor: Color(0xFF5CE1E6),
      unselectedItemColor: Color(0xFF7F7F7F),
      items:[
        BottomNavigationBarItem(icon: Icon(Icons.account_box,), label: "پروفایل"),
        BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "خانه"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,), label: "سبد خرید"),
        // BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Acount"),

      ],

      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}


