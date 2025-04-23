import 'package:flutter/material.dart';
import 'package:practice2/main.dart';


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
      _selectedIndex = 0;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyShop())
      );
    }

    if (index == 1){
      _selectedIndex = 1;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductsPage())
      );
    };

    if (index == 2){
      _selectedIndex = 2;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BasketPage())
      );
    };
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF0C2D48),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFF7F7F7F),
      items:[
        BottomNavigationBarItem(icon: Icon(Icons.login_sharp,), label: "حساب کاربری"),
        BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "خانه"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,), label: "سبد"),
        // BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Acount"),

      ],

      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}


