import 'package:flutter/material.dart';
import 'widgets/staticWidgets/navigationBottom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'session/sessionStatus.dart';
import 'screen/login.dart';
import 'screen/infoAccount.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هکس ارنا',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/account': (context) => InfoAcountPage(),
      },
    );
  }
}


class Product{
  int id;
  String name;
  String description;
  int quantity;
  String picPath;
  var price;

  Product({required this.id,required this.name, required this.description, required this.quantity,required this.price, required this.picPath});
}

class Order{
  String name;
  int quantity;
  String picPath;
  var price;

  Order({required this.name, required this.quantity, required this.price, required this.picPath});
}

final List<Product> products = [
  Product(id: 1,
      name: "Red Dead Redemption 2",
      description: "کمتر کسی است که نام Rockstar Games را نشنیده باشد و آثار معروف و قوی این کمپانی قدرتمند را نشناسد. این سازنده‌ی خلاق، جایزه‌ی بهترین بازی سال را از مراسم مختلفی برای بازی‌های مختلف خود دریافت کرده است. یکی از مشهورترین سری بازی‌های Rockstar، سری Red Dead است که نسخه‌ی دوم آن، Read Dead Redemption در سال 2010 به عنوان بهترین بازی سال انتخاب شد.",
      quantity: 20,
      price: 4200000,
      picPath: "assets/img/red-dead2.jpg"),

  Product(id: 2,
      name: "Cyberpunk 2077",
      description: "بازی سایبرپانک ۲۰۷۷ در یک ابر شهر واقع در ایالات کارولینای شمالی دنبال می‌شود که توسط کمپانی‌های بزرگ اداره می‌شود اما قوانین حکومتی هم هنوز به طرز ضعیف‌تری بر مردم واقع است. اختلاف طبقاتی کاری کرده تا مردم شهر در قسمت‌های مختلف جا بگیرند که هرکدام ویژگی‌ها و فرهنگ خاص خودشان رادارند. بخشی از شهر با برج‌های چند صد طبقه پرشده که مردمانی ثروتمند با کت‌وشلوارهای شیک و ماشین‌های گران‌قیمت در آن‌ها زندگی می‌کنند. اما تمامی قسمت‌های شهر به این شکل نیست و انواع گروه‌های تبه‌کاران در قسمت‌های مختلف دیده می‌شوند که هرکدام با دیگری در جنگ و جدال عجیبی هستند. قشر فقیر زیادی در شهر زندگی می‌کنند که باعث افزایش میزان خشونت و تهدیدهای جدی از سوی گروه‌های خلاف‌کار شده است. اما شما از کجا وارد می‌شوید؟",
      quantity: 20,
      price: 4800000,
      picPath: "assets/img/cyberpunk.jpg"),

  Product(id: 3,
      name: "The Last of Us Part 2 Remastered",
      description: "بازی The Last of Us Part II یکی از تحسین‌شده‌ترین و پرفروش‌ترین بازی‌های تاریخ است که توسط استودیو ناتی‌داگ ساخته شده است. این بازی در دنیایی پساآخرالزمانی و آلوده به ویروسی کشنده جریان دارد که انسان‌ها و بازماندگان آن‌ها باید برای بقا در برابر تهدیدات ناشی از موجودات آلوده و انسان‌های خشن و بی‌رحم، مبارزه کنند. داستان بازی حول محور دو شخصیت اصلی، الی و ابی، می‌چرخد که در مسیری پر از درد، فداکاری و انتقام در دنیایی پر از تاریکی و خشونت تلاش می‌کنند تا عدالت را برقرار کنند و با گذشته خود کنار بیایند. بازی The Last of Us Part II Remastered با ارتقاء‌های گرافیکی، ویژگی‌های جدید و بهبودهای چشمگیر در گیم‌پلی، به‌عنوان نسخه‌ای نهایی و جامع از این داستان پیچیده و عاطفی شناخته می‌شود.",
      quantity: 20,
      price: 3800000,
      picPath: "assets/img/tlou.jpg"),

  Product(id: 4,
      name: "The Witcher 3: Wild Hunt",
      description: "قطعاً تا به امروز نام سری بازی‌های ویچر به گوش شما خورده است. این سری محبوب و فانتزی، در یک دنیای جادویی و وسیع جریان داشته و ماجراجویی‌های شخصیتی به نام گرالت را دنبال می‌کند که یک Witcher است، افرادی تعلیم دیده و جهش‌یافته برای مبارزه با خطرناک‌ترین هیولاها و موجوداتی که جان انسان‌ها را تهدید می‌کنند. این بازی‌ها به صورت یک سه‌گانه منتشر شدند که آخرین شماره آن یعنی بازی The Witcher 3 Wild Hunt با تغییراتی اساسی توانست به یکی از به‌یادماندنی‌ترین و بهترین بازی‌های صنعت ویدیوگیم تبدیل شود و کارنامه درخشانی برای استودیو سازنده‌اش یعنی CD Projekt Red ایجاد کند. مهم‌ترین تغییر این بازی را می‌توان به تبدیل‌شدنش به یک بازی جهان باز با نقشه‌ای وسیع و گرافیک خیره‌کننده اشاره کرد. به تازگی با آپدیت جدیدی که برای بازی ویچر 3 آمده، گرافیک و جلوه‌های بصری آن بیش از پیش بهبود یافته و تکنیک‌های نسل جدید گرافیکی را به آن اضافه کرده تا تجربه‌ای لذت‌بخش در آن داشته باشید. این به‌روزرسانی به صورت رایگان در اختیار تمام بازیکنان قرار گرفته است.",
      quantity: 20,
      price: 4500000,
      picPath: "assets/img/witcher3.jpg"),
];

bool isLoggedIn = true ? globalUserId != null : false;

final List<Order> orders = [];

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


// class MyShop extends StatefulWidget {
//   const MyShop({super.key});
//
//   @override
//   State<MyShop> createState() => _MyShopState();
// }

// class _MyShopState extends State<MyShop> {
//   TextEditingController username = new TextEditingController();
//   TextEditingController password = new TextEditingController();
//   String result = "";
//   String? errorUsername = null;
//   String? errorPassword = null;
//   Color color = Colors.blueAccent;
//   int bottomNavigationSelector = 0;
//   action(index){
//     setState(() {
//       if (index == 0){
//         bottomNavigationSelector = 0;
//       }
//
//     });
//   }
//
//   Future<void> loginUser(String username, String password, BuildContext context) async{
//     final response = await http.post(
//         Uri.parse('http://192.168.140.91:5000/api/user/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'username': username,
//         'password': password,
//       })
//     );
//
//     print('+++++++++++++++++ Response body: ${response.body} +++++++++++++++++');
//     print('+++++++++++++++++ Status code: ${response.statusCode} +++++++++++++++++');
//
//     final resultData = jsonDecode(response.body);
//     if (response.statusCode == 200){
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ProductsPage()),
//       );
//     } else if (response.statusCode == 400) {
//       print('&&&&&&&&&&&&&&& Status code: ${response.statusCode} &&&&&&&&&&&&&&&');
//
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Color(0xFF0C2D48),
//
//             title: Text("خطا",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Color(0xFFFF8B48)
//               ),
//             ),
//             content: Text("نام کاربری یا رمز عبور اشتباه است.",
//               textAlign: TextAlign.center,
//               textDirection: TextDirection.rtl,
//               style: TextStyle(
//                 color: Color(0xFFE16C6C)
//               ),
//             ),
//             actions: [
//               TextButton(
//                 child: Center(child: Text("بستن",
//                   style: TextStyle(
//                     color: Color(0xFF6CE183)
//                   ),
//                 )),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//
//
//   }
//
//   bool checkUserPassFormating(String input){
//     final regex = RegExp(r"^[a-zA-Z0-9]{4,}$");
//     if (regex.hasMatch(input)){
//       return true;
//     }
//     return false;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//       theme: ThemeData(
//         fontFamily: "Irancell"
//       ),
//       home: Container(
//         decoration: BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment(0, 0), // near the top right
//             radius: 0.8,
//             colors: <Color>[
//               Color(0xFF145DA0), //  sun
//               Color(0xFF0C2D48), //  sky
//             ],
//             )
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(title: Center
//             (child: Text("هکس آرنا",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 30,
//             fontWeight: FontWeight.bold
//           ),
//           ),
//           ),
//             backgroundColor: Color(0xFF0C2D48),
//           ),
//
//           body: Container(
//
//             child: ListView(
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
//                   child: Column(
//                     children: [
//                       Image(image: AssetImage('assets/img/game-vector.png'),
//                       width: 300,
//                         height: 150,
//                       ),
//
//                       Center(
//                         child: Text("ورود به حساب کاربری",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFFFFFFF),
//                         ),
//                         ),
//                       ),
//                     ]
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(50, 10, 50, 1),
//                   child: TextField(
//
//                     textAlign: TextAlign.center,
//                     controller: username,
//                     decoration: InputDecoration(
//                       errorText: errorUsername,
//                       hintText: "نام کاربری",
//                         hintStyle: TextStyle(
//                           color: Color(0x9EFFFFFF),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400
//                         ),
//                       contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
//                       borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
//                       ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         borderSide: BorderSide(
//                           color: Color(0xFFFFFFFF),
//                           width: 0.5,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         borderSide: BorderSide(
//                           color: Color(0x9E0084FF),
//                           width: 1.5,
//                         ),
//                       ),
//                       fillColor: Color(0x3BFFFFFF),
//                       filled: true,
//
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
//                   child: TextField(
//                     textAlign: TextAlign.center,
//                     controller: password,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                         hintText: "رمز عبور",
//                         hintStyle: TextStyle(
//                           color: Color(0x9EFFFFFF),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400
//                         ),
//
//                         errorText: errorPassword,
//                       contentPadding: EdgeInsets.fromLTRB(20, 1, 20, 1),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
//                         borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2.0
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         borderSide: BorderSide(
//                           color: Color(0xFFFFFFFF),
//                           width: 0.5,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         borderSide: BorderSide(
//                           color: Color(0x9E0084FF),
//                           width: 1.5,
//                         ),
//                       ),
//                       fillColor: Color(0x3BFFFFFF),
//                       filled: true,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(50, 20, 50, 1),
//                   child: MaterialButton(
//                       padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50))
//                       ),
//                       color: Color(0xFF0C2D48),
//                       child: Text("ارسال",
//                       style: TextStyle(color: Colors.white),),
//
//                       onPressed: (){
//                         // setState(() {
//                         //   errorUsername = null;
//                         //   if (!checkUserPassFormating(username.text)){
//                         //     errorUsername = "فرمت نام کاربری صحیح نمی باشد.";
//                         //   }
//                         //
//                         //   errorPassword = null;
//                         //   if (!checkUserPassFormating(password.text)){
//                         //     errorPassword = "فرمت رمز عبور صحیح نمی باشد.";
//                         //   }
//                         //
//                         //   else if (username.text == "admin" && password.text == "12345"){
//                         //     isLoggedIn = true;
//                         //     Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(builder: (context) => ProductsPage()),
//                         //     );
//                         //     color = Colors.blueAccent;
//                         //     result = "Welcome";
//                         //
//                         //   }
//                         //   else {
//                         //     result = "Error";
//                         //     color = Colors.redAccent;
//                         //     }
//                         //
//                         //
//                         // });
//                         loginUser(username.text, password.text, context);
//                       }),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
//                   child: Center(child: Text(result,
//                     style: TextStyle(
//                       color: color,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//             bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
//         ),
//       ),
//     );
//   }
// }

// class InfoAcountPage extends StatefulWidget {
//   const InfoAcountPage({super.key});
//
//   Future<void> getInfo(id) async{
//
//   }
//   @override
//   State<InfoAcountPage> createState() => _InfoAcountPageState();
// }
//
// class _InfoAcountPageState extends State<InfoAcountPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//         fontFamily: "Irancell"
//     ),
//     home: Container(
//     decoration: BoxDecoration(
//     gradient: RadialGradient(
//     center: Alignment(0, 0), // near the top right
//     radius: 0.8,
//     colors: <Color>[
//     Color(0xFF145DA0), //  sun
//     Color(0xFF0C2D48), //  sky
//     ],
//     )
//     ),
//
//     child: Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(title: Center
//         (child: Text("حساب کاربری",
//         style: TextStyle(
//             color: Colors.white,
//             fontSize: 30,
//             fontWeight: FontWeight.bold
//         ),
//       ),
//       ),
//         backgroundColor: Color(0xFF0C2D48),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // cards
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFF05121C),
//                     borderRadius: BorderRadius.circular(50),
//                     boxShadow: [
//                       BoxShadow(color: Color(0xFF2E8ABF), blurRadius: 5),
//                     ],
//                   ),
//                   margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
//                   child: Column(
//                     children: [
//
//                       Container(
//                         padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF05121C),
//                           borderRadius: BorderRadius.circular(5),
//                           boxShadow: [
//                             BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 1),
//                           ],
//                         ),
//                         margin: EdgeInsets.fromLTRB(40, 40, 40, 2),
//                         child: Center(
//                           child: Text(
//                             'نام و نام خانوادگی',
//                             style: TextStyle(
//                               color: Color(0xFF81B5D3),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                         padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF05121C),
//                           borderRadius: BorderRadius.circular(5),
//                           boxShadow: [
//                             BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 1),
//                           ],
//                         ),
//                         margin: EdgeInsets.fromLTRB(40, 50, 40, 2),
//                         child: Center(
//                           child: Text(
//                             'نام کاربری',
//                             style: TextStyle(
//                               color: Color(0xFF81B5D3),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                         padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF05121C),
//                           borderRadius: BorderRadius.circular(5),
//                           boxShadow: [
//                             BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 1),
//                           ],
//                         ),
//                         margin: EdgeInsets.fromLTRB(40, 50, 40, 2),
//                         child: Center(
//                           child: Text(
//                             'شماره تلفن',
//                             style: TextStyle(
//                               color: Color(0xFF81B5D3),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.fromLTRB(40, 50, 40, 40),
//                         child: ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF0C2D48),
//                           ),
//                           onPressed: () {
//                           },
//                           icon: Icon(Icons.exit_to_app,
//                             color: Color(0xFFEC565A),
//                           ),
//                           label: Text("خروج",
//                             style: TextStyle(
//                               color: Color(0xFFEC565A),
//                               fontWeight: FontWeight.w700
//
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 0,),
//       )
//     )
//     );
//   }
// }

// class ProductsPage extends StatefulWidget {
//   const ProductsPage({super.key});
//
//   @override
//   State<ProductsPage> createState() => _ProductsPageState();
// }
//
// class _ProductsPageState extends State<ProductsPage> {
//
//   String formatNumber(int number) {
//     final str = number.toString();
//     final buffer = StringBuffer();
//     int counter = 0;
//
//     for (int i = str.length - 1; i >= 0; i--) {
//       buffer.write(str[i]);
//       counter++;
//       if (counter % 3 == 0 && i != 0) {
//         buffer.write(',');
//       }
//     }
//
//     return buffer.toString().split('').reversed.join('');
//   }
//
//   addProductToCard({required Product prdc}){
//     setState(() {
//       int index = orders.indexWhere((e) => e.name == prdc.name);
//       print("\n\n\n ${index} \n\n\n");
//       if (index != -1){
//         orders[index].quantity += 1;
//       }
//       else {
//         orders.add(
//             Order(name: prdc.name, quantity: 1, price: prdc.price, picPath: prdc.picPath)
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: "Irancell"
//         ),
//       home: Container(
//         decoration: BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment(0, 0), // near the top right
//             radius: 0.8,
//             colors: <Color>[
//             Color(0xFF145DA0), //  sun
//             Color(0xFF0C2D48), //  sky
//             ],
//           )
//         ),
//
//     child: Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(title: Center
//         (child: Text("محصولات",
//         style: TextStyle(
//         color: Colors.white,
//         fontSize: 30,
//         fontWeight: FontWeight.bold
//             ),
//           ),
//         ),
//         backgroundColor: Color(0xFF0C2D48),
//         ),
//
//       body: globalUserId != null
//       ?Container(
//         padding: EdgeInsets.all(8),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               for (var item in products)
//               // cards
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFF05121C),
//                     borderRadius: BorderRadius.circular(50),
//                     boxShadow: [
//                       BoxShadow(color: Color(0xFF2E8ABF), blurRadius: 5),
//                     ],
//                   ),
//                   margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(40),
//                           child: Image.asset(
//                             item.picPath,
//                             width: 310,
//                             fit: BoxFit.cover,
//
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                         child: Center(
//                           child: Text(
//                             item.name,
//                             style: TextStyle(
//                               color: Color(0xFF81B5D3),
//                               fontWeight: FontWeight.w700,
//                               fontSize: 18,
//                               ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
//                         child: Text(item.description,
//                           textAlign: TextAlign.right,
//                             textDirection: TextDirection.rtl,
//                           style: TextStyle(
//                             color: Color(0xFFF5F9FB),
//                             fontWeight: FontWeight.w300,
//                             fontSize: 12,
//                             height: 2.5
//
//                           ),),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                         child: Center(
//                           child: Text(
//                             formatNumber(item.price) + " تومان",
//                             textDirection: TextDirection.rtl,
//                             style: TextStyle(color: Color(0xFF00FF42)),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
//                         child: ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF0C2D48),
//                           ),
//                           onPressed: () {
//                           // Add to Bascket
//                             addProductToCard(prdc: item);
//                             // show
//                             print(orders);
//                             for (var item in orders){
//                               print("Name: ${item.name}, Pic Path: ${item.picPath}, Price: ${item.price}");
//                             }
//                           },
//                           icon: Icon(Icons.add_shopping_cart),
//                           label: Text("افزودن به سبد"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       )
//       :Center(
//     child: Text(
//     "برای مشاهده محصولات باید وارد شوید.",
//         textDirection: TextDirection.rtl,
//         style: TextStyle(color: Colors.white, fontSize: 18),
//       ),
//     ),
//
//       bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 1,)
//
//     ),
//         ),
//     );
//   }
// }

// class BasketPage extends StatefulWidget {
//   const BasketPage({super.key});
//
//   @override
//   State<BasketPage> createState() => _BasketPageState();
// }
//
// class _BasketPageState extends State<BasketPage> {
//
//   double sumOfAllForBascket(List<Order> ors){
//     double sum = 0;
//     for (var item in ors){
//       sum += item.price * item.quantity;
//     }
//     return sum;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           fontFamily: "Irancell"
//       ),
//       home: Container(
//         decoration: BoxDecoration(
//             gradient: RadialGradient(
//               center: Alignment(0, 0), // near the top right
//               radius: 0.8,
//               colors: <Color>[
//                 Color(0xFF145DA0), //  sun
//                 Color(0xFF0C2D48), //  sky
//               ],
//             )
//         ),
//
//         child: Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(title: Center
//               (child: Text("سبد خرید",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//             ),
//               backgroundColor: Color(0xFF0C2D48),
//             ),
//
//             body: globalUserId != null ?Container(
//               padding: EdgeInsets.all(8),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (var item in orders)
//                     // first card
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFF05121C),
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(color: Color(0xFF2E8ABF), blurRadius: 2),
//                         ],
//                       ),
//                       margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
//                       child: Row(
//                         children: [
//
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                   topRight: Radius.circular(3),
//                                   bottomRight: Radius.circular(3)
//                               ),
//                               child: Image.asset(
//
//                                 item.picPath,
//
//                                 width: 100,
//                                 fit: BoxFit.cover,
//
//                               ),
//                             ),
//                           ),
//
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               child: Column(
//                                 children: [
//                                     Text(
//                                       "عنوان بازی:",
//                                       textAlign: TextAlign.right,
//                                       textDirection: TextDirection.rtl,
//                                       style: TextStyle(
//                                         color: Color(0xFF81B5D3),
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 14,
//                                         height: 2,
//                                       ),
//                                     ),
//
//                                     Text(
//                                       item.name,
//                                       textAlign: TextAlign.center,
//                                       textDirection: TextDirection.rtl,
//                                       style: TextStyle(
//                                         color: Color(0xFF81B5D3),
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 14,
//                                         height: 2,
//                                       ),
//                                     ),
//
//                                     Text(
//                                       "تعداد: " + "${item.quantity}",
//                                       textAlign: TextAlign.right,
//                                       textDirection: TextDirection.rtl,
//                                       style: TextStyle(
//                                         color: Color(0xFFF5F9FB),
//                                         fontWeight: FontWeight.w300,
//                                         fontSize: 12,
//                                         height: 2.5,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFF05121C),
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(color: Color(0xFF2E8ABF), blurRadius: 2),
//                         ],
//                       ),
//                       margin: EdgeInsets.fromLTRB(30, 50, 30, 10),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               child: Column(
//
//                                 children: [
//                                   Text(
//                                     "مبلغ قایل پرداخت:",
//                                     textAlign: TextAlign.right,
//                                     textDirection: TextDirection.rtl,
//                                     style: TextStyle(
//                                       color: Color(0xFFFE6A48),
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 14,
//                                       height: 2,
//                                     ),
//                                   ),
//
//                                   Text(
//                                    "${formatNumber(sumOfAllForBascket(orders).toInt())}" + " تومان" ,
//                                     textAlign: TextAlign.center,
//                                     textDirection: TextDirection.rtl,
//                                     style: TextStyle(
//                                       color: Color(0xFF13FF00),
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 14,
//                                       height: 2,
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           )
//
//
//                         ],
//                       ),
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             )
//             :Center(
//           child: Text(
//           "برای مشاهده محصولات باید وارد شوید.",
//           textDirection: TextDirection.rtl,
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//
//             bottomNavigationBar: MyNavigationBottomBar(InitializeIndex: 2,)
//
//         ),
//       ),
//     );
//   }
// }
//

