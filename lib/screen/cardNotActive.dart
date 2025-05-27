import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice2/serverConfiguration/serverAddress.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import '../session/sessionStatus.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../screen/basketHistory.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';

class CardItem {
  int id;
  String name;
  String description;
  int price;
  int quantity;
  String picPath;

  CardItem({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.picPath,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['product_id'],
      name: json['product_name'],
      description: json['product_description'],
      quantity: json['quantity'],
      price: json['product_price'],
      picPath: json['img_path'],
    );
  }
}

bool? itemsStatus = null;

class DisplayNotActiveBasketPage extends StatefulWidget {
  final basketId;

  const DisplayNotActiveBasketPage({super.key, this.basketId});

  @override
  State<DisplayNotActiveBasketPage> createState() =>
      _DisplayNotActiveBasketPage();
}

class _DisplayNotActiveBasketPage extends State<DisplayNotActiveBasketPage> {
  Future<List<CardItem>> fetchBasket() async {
    print('in card');
    final response = await http.get(
      Uri.parse(
        '$server/api/user/$globalUserId/basket_not_active/${widget.basketId}',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        itemsStatus = true;
      });
      print('dddffffff');
      print(orderItems);
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => CardItem.fromJson(item)).toList();
    } else {
      setState(() {
        itemsStatus = false;
      });
      throw Exception('حطا در دریافت اطلاعات');
    }
  }

  double sumOfAllForBascket(List<CardItem> ors) {
    double sum = 0;
    for (var item in ors) {
      sum += item.price * item.quantity;
    }
    return sum;
  }

  String formatNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    int counter = 0;

    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      counter++;
      if (counter % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }

    return buffer.toString().split('').reversed.join('');
  }

  List<CardItem> orderItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCard();
  }

  Future<void> loadCard() async {
    final data = await fetchBasket();
    setState(() {
      orderItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Irancell"),
      home: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0), // near the top right
            radius: 0.8,
            colors: <Color>[
              Color(0xFF263375), //  sun
              Color(0xFF0A0E21), //  sky
            ],
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Image.asset(
              'assets/img/new-logo-blue-edited-appbar.png',
              width: 90,
            ),

            // Center
            //   (child: Text("هکس آرنا",
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold
            //   ),
            // ),
            centerTitle: true,
            backgroundColor: Color(0xFF0A0E21),
            automaticallyImplyLeading: false,

            actions: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
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
                            CardsHistory(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
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

          body:
              globalUserId != null
                  ? Container(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child:
                          itemsStatus != false
                              ? Column(
                                children: [
                                  for (var item in orderItems)
                                    // first card
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF05121C),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF9F00FF),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.fromLTRB(
                                        30,
                                        10,
                                        30,
                                        10,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                topRight: Radius.circular(3),
                                                bottomRight: Radius.circular(3),
                                              ),
                                              child: Image.network(
                                                '$server${item.picPath}',

                                                width: 100,
                                                fit: BoxFit.cover,
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
                                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "عنوان بازی:",
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      color: Color(0xFF5CE1E6),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      height: 2,
                                                    ),
                                                  ),

                                                  Text(
                                                    item.name,
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      color: Color(0xFF5CE1E6),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      height: 4,
                                                    ),
                                                  ),

                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    mainAxisSize:
                                                        MainAxisSize.min,

                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Center(
                                                          child: Text(
                                                            "تعداد: " +
                                                                "${item.quantity}",
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xFFF5F9FB,
                                                              ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              height: 2.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF05121C),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF5CE1E6),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.fromLTRB(30, 50, 30, 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "مبلغ پرداخت شده:",
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Color(0xFF5CE1E6),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    height: 2,
                                                  ),
                                                ),
                                                Text(
                                                  "${formatNumber(sumOfAllForBascket(orderItems).toInt())}" +
                                                      " تومان",
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Color(0xFF13FF00),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    height: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              : Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF05121C),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF2E8ABF),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.fromLTRB(30, 50, 30, 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "مبلغ قایل پرداخت:",
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Color(0xFF5CE1E6),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                height: 2,
                                              ),
                                            ),
                                            itemsStatus != false
                                                ? Text(
                                                  "${formatNumber(sumOfAllForBascket(orderItems).toInt())}" +
                                                      " تومان",
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Color(0xFF13FF00),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    height: 2,
                                                  ),
                                                )
                                                : Text(
                                                  "0" + " تومان",
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Color(0xFF13FF00),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    height: 2,
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  )
                  : Center(
                    child: Text(
                      "برای مشاهده محصولات باید وارد شوید.",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

          bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 1),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: MyFloatingActionButton(),
        ),
      ),
    );
  }
}
