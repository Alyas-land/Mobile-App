import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice2/screen/productsPage.dart';
import '../screen/aboutUs.dart';
import '../serverConfiguration/serverAddress.dart';
import '../widgets/staticWidgets/drawerMenu.dart';
import '../widgets/staticWidgets/navigationBottom.dart';
import '../widgets/staticWidgets/floatingActionButton.dart';


class Category {
  final int id;
  final String title;
  final String imagePath;

  Category({required this.id, required this.title, required this.imagePath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        title: json['title'],
        id: json['id'],
        imagePath: json['img_path'],

    );
  }
}



class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


// Fetch products data from Backend
  Future<List<Category>> fetchCategory() async{
    final response = await http.get(
      Uri.parse('$server/api/user/category'),
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200){
      print('in if');
      print(response.body);
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Category.fromJson(item)).toList();
    }
    else {
      throw Exception('خطا در دریافت کتگوری');
    }
  }
  // End fetch products data from Backend
  List<Category> categories = [];
  Future<void> loadCategory() async{
    final data = await fetchCategory();
    setState(() {
      categories = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategory();

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
              width: 90,
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Color(0xFF0A0E21),
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
          ),

          endDrawer: MyDrawerMenu(),

          body: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    Opacity(
                      opacity: 0.4,
                      child: Image.network(
                        '$server/${category.imagePath}',

                        width: double.infinity,
                        height: 120,
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

                    Text(
                      category.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 6.0,
                            color: Colors.black87,
                            offset: Offset(1.5, 1.5),
                          ),
                        ],
                      ),
                    ),

                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ProductsPage(categoryId: category.id,),
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
                                transitionDuration: Duration(milliseconds: 1500),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),



            bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 1,),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: MyFloatingActionButton()


        ),
      ),
    );
  }
}
