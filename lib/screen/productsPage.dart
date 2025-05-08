import 'package:flutter/material.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../session/sessionStatus.dart';

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
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  Future<List<Product>> fetchProducts() async{
    final response = await http.get(
      Uri.parse('http://192.168.139.91:5000/api/user/products'),
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200){
      print('in if');
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    }
    else {
      throw Exception('خطا در دریافت مخصولات');
    }
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
                Color(0xFF145DA0), //  sun
                Color(0xFF0C2D48), //  sky
              ],
            )
        ),

        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(title: Center
              (child: Text("محصولات",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            ),
              backgroundColor: Color(0xFF0C2D48),
            ),

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
                                  'http://192.168.139.91:5000${item.imgPath}',
                                  width: 310,
                                  fit: BoxFit.cover,

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
                                },
                                icon: Icon(Icons.add_shopping_cart),
                                label: Text("افزودن به سبد"),
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

            bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 1,)

        ),
      ),
    );
  }
}