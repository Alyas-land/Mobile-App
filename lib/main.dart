import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Navigation Basics', home: MyShop()));
}

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String result = "";
  String? errorUsername = null;
  String? errorPassword = null;
  Color color = Colors.blueAccent;
  int bottomNavigationSelector = 0;
  action(index){
    setState(() {
      if (index == 0){
        bottomNavigationSelector = 0;
      }

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
            (child: Text("هکس آرنا",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          ),
          ),
            backgroundColor: Color(0xFF0C2D48),
          ),

          body: Container(

            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/img/game-vector.png'),
                      width: 300,
                        height: 150,
                      ),

                      Center(
                        child: Text("ورود به حساب کاربری",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                        ),
                      ),
                    ]
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
                  child: TextField(

                    textAlign: TextAlign.center,
                    controller: username,
                    decoration: InputDecoration(
                      errorText: errorUsername,
                      hintText: "نام کاربری",
                        hintStyle: TextStyle(
                          color: Color(0x9EFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                      ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0x9E0084FF),
                          width: 1.5,
                        ),
                      ),
                      fillColor: Color(0x3BFFFFFF),
                      filled: true,

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "رمز عبور",
                        hintStyle: TextStyle(
                          color: Color(0x9EFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),

                        errorText: errorPassword,
                      contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Color(0x9E0084FF),
                          width: 1.5,
                        ),
                      ),
                      fillColor: Color(0x3BFFFFFF),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      color: Color(0xFF0C2D48),
                      child: Text("ارسال",
                      style: TextStyle(color: Colors.white),),

                      onPressed: (){
                        setState(() {
                          errorUsername = null;
                          if (username.text.length < 3){
                            errorUsername = "فرمت نام کاربری درست نمی باشد";
                          }

                          errorPassword = null;
                          if (password.text.length < 4){
                            errorPassword = "رمز عبور باید بیشتر از 4 کاراکتر باشد.";
                          }

                          else if (username.text == "admin" && password.text == "12345"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductsPage()),
                            );
                            color = Colors.blueAccent;
                            result = "Welcome";

                          }
                          else {
                            result = "Error";
                            color = Colors.redAccent;
                            }


                        });
                      }),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: Center(child: Text(result,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  ),
                ),

              ],
            ),
          ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xFF0C2D48),
              selectedItemColor: Colors.white,
              unselectedItemColor: Color(0xFF7F7F7F),
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.login_sharp,), label: "حساب کاربری"),
                BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "خانه"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,), label: "سبد"),
                // BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Acount"),

              ],
              currentIndex: bottomNavigationSelector,
              onTap: action,
            ),
        ),
      ),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int bottomNavigationSelector = 1;
  action(index){
    setState(() {
      if (index == 0){
        bottomNavigationSelector = 0;
      }
      else if (index == 1){
        bottomNavigationSelector = 1;
      }

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

      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // first card
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
                        child: Image.asset(
                          "assets/img/red-dead2.jpg",
                          width: 310,
                          fit: BoxFit.cover,

                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Center(
                        child: Text(
                          "Red Dead Redemption 2",
                          style: TextStyle(
                            color: Color(0xFF81B5D3),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Text("کمتر کسی است که نام Rockstar Games را نشنیده باشد و آثار معروف و قوی این کمپانی قدرتمند را نشناسد. این سازنده‌ی خلاق، جایزه‌ی بهترین بازی سال را از مراسم مختلفی برای بازی‌های مختلف خود دریافت کرده است. یکی از مشهورترین سری بازی‌های Rockstar، سری Red Dead است که نسخه‌ی دوم آن، Read Dead Redemption در سال 2010 به عنوان بهترین بازی سال انتخاب شد.",
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
                          "4,500,000 تومان",
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
                          // افزودن به سبد خرید
                        },
                        icon: Icon(Icons.add_shopping_cart),
                        label: Text("افزودن به سبد"),
                      ),
                    ),
                  ],
                ),
              ),

              // next card
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
                        child: Image.asset(
                          "assets/img/cyberpunk.jpg",
                          width: 310,
                          fit: BoxFit.cover,

                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Center(
                        child: Text(
                          "Cyberpunk 2077",
                          style: TextStyle(
                            color: Color(0xFF81B5D3),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Text("بازی سایبرپانک ۲۰۷۷ در یک ابر شهر واقع در ایالات کارولینای شمالی دنبال می‌شود که توسط کمپانی‌های بزرگ اداره می‌شود اما قوانین حکومتی هم هنوز به طرز ضعیف‌تری بر مردم واقع است. اختلاف طبقاتی کاری کرده تا مردم شهر در قسمت‌های مختلف جا بگیرند که هرکدام ویژگی‌ها و فرهنگ خاص خودشان رادارند. بخشی از شهر با برج‌های چند صد طبقه پرشده که مردمانی ثروتمند با کت‌وشلوارهای شیک و ماشین‌های گران‌قیمت در آن‌ها زندگی می‌کنند. اما تمامی قسمت‌های شهر به این شکل نیست و انواع گروه‌های تبه‌کاران در قسمت‌های مختلف دیده می‌شوند که هرکدام با دیگری در جنگ و جدال عجیبی هستند. قشر فقیر زیادی در شهر زندگی می‌کنند که باعث افزایش میزان خشونت و تهدیدهای جدی از سوی گروه‌های خلاف‌کار شده است. اما شما از کجا وارد می‌شوید؟",
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
                          "4,800,000 تومان",
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
                          // افزودن به سبد خرید
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
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0C2D48),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF7F7F7F),
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.login_sharp,), label: "حساب کاربری"),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "خانه"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,), label: "سبد"),
          // BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Acount"),

        ],
        currentIndex: 1,
        onTap: action,
      ),

    ),




        ),



    );
  }
}

