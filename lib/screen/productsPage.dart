import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:practice2/screen/category.dart';
import 'package:practice2/serverConfiguration/serverAddress.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../session/sessionStatus.dart';
import 'package:another_flushbar/flushbar.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';




class Product{
  int id;
  String name;
  String description;
  String imgPath;
  int price;

  Product ({required this.id, required this.name, required this.description, required this.imgPath, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      id: json['id'],
      description: json['description'],
      price: json['price'],
      imgPath: json['imgPath']
    );
  }

}
class ProductsPage extends StatefulWidget {
  final int? categoryId;

  const ProductsPage({super.key, this.categoryId});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  // Fetch products data from Backend
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$server/api/user/products/category/${widget.categoryId}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => Product.fromJson(item)).toList();
      } else {
        // نمایش خطای سمت سرور با جزئیات
        throw Exception(
            'خطای سرور (${response.statusCode}): ${response.body}');
      }
    } catch (e, stackTrace) {
      // نمایش هر خطای دیگر (مثلاً خطای شبکه، پارس کردن JSON و...)
      throw Exception('خطا در دریافت محصولات: $e\n$stackTrace');
    }
  }
  // End fetch products data from Backend


  // Add product to card
  Future<void> addProductToCard(productId) async {
    final response = await http.post(
      Uri.parse('$server//api/user/products/add_to_card'),
        headers: {
          'Content-Type': 'application/json',
        },
      body: jsonEncode(
        {
          'user_id': globalUserId,
          'product_id': productId,
        }
      )
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
        messageText: Text('کالا با موفقیت اضافه شد',
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
    else {
      Flushbar(
        titleText: Text('*عملیات ناموفق*',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text('کالا به سبد خرید اضافه نشد',
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
        backgroundColor: Colors.red,

      ).show(context);
    }
  }
  // End add product to card

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

  // addProductToCard({required Product prdc}){
  //   setState(() {
  //     int index = orders.indexWhere((e) => e.name == prdc.name);
  //     print("\n\n\n ${index} \n\n\n");
  //     if (index != -1){
  //       orders[index].quantity += 1;
  //     }
  //     else {
  //       orders.add(
  //           Order(name: prdc.name, quantity: 1, price: prdc.price, picPath: prdc.picPath)
  //       );
  //     }
  //   });
  // }

  List<Product> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProduct();
  }

  Future<void> loadProduct() async{
    final data = await fetchProducts();
    setState(() {
      products = data;
    });
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

          // Center
          //   (child: Text("هکس آرنا",
          //   style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 30,
          //       fontWeight: FontWeight.bold
          //   ),
          // ),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF0A0E21),
              centerTitle: true,

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
                          CategoryPage(),
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
                      transitionDuration: Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
            ),

            endDrawer: MyDrawerMenu(),

            body: globalUserId != null
                ?Container(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var item in products)
                    // cards
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF05121C),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(color: Color(0xFF2E8ABF), blurRadius: 5),
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  '$server/${item.imgPath}',
                                  width: 310,
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


                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Center(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    color: Color(0xFF81B5D3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.5,
                                      color: Colors.white60,
                                    style: BorderStyle.solid
                                  ),
                                  top: BorderSide(
                                    width: 1.5,
                                    color: Colors.white60,
                                    style: BorderStyle.solid
                                )
                                )
                              ),
                              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Text(item.description,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Color(0xFFF5F9FB),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    height: 2.5

                                ),),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Center(
                                child: Text(
                                  formatNumber(item.price) + " تومان",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Color(0xFF00FF42)),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0C2D48),
                                ),
                                onPressed: () {
                                  // Add to Bascket
                                  // addProductToCard(prdc: item);
                                  // // show
                                  // print(orders);
                                  // for (var item in orders){
                                  //   print("Name: ${item.name}, Pic Path: ${item.picPath}, Price: ${item.price}");
                                  // }
                                  addProductToCard(item.id);
                                },
                                icon: Icon(Icons.add_shopping_cart,
                                color: Colors.blue,),
                                label: Text("افزودن به سبد",
                                style: TextStyle(
                                  color: Colors.blue
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            )
                :Center(
              child: Text(
                "برای مشاهده محصولات باید وارد شوید.",
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 1,),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: MyFloatingActionButton()

        ),
      ),
    );
  }
}