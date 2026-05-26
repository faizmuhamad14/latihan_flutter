import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latihan_flutter/day18/profile.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});
  static const String routeName = '/signup';

  @override
  State<SignUpPage2> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Color(0xFFaec6cf), Colors.white, Color(0xFFffdab9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 2),
          margin: EdgeInsets.all(24),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 9,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffaec6cf),
                      ),
                      child: Icon(Icons.favorite),
                    ),
                    Text(
                      "Buat Akun Baru",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Bergabunglah dengan Sahabat Bulu untuk merawat hewan peliharaan Anda dengan lebih baik.",
                    ),
                    // SizedBox(height: 15),
                    Column(
                      spacing: 7,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Lengkap",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Masukkan nama",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Masukkam alamat email",
                            hintText: "Masukkan alamat email",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            } else if (!value.contains('@')) {
                              return "Format email tidak valid";
                            }
                            return null;
                          },
                        ),

                        Text(
                          "Nomer",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Nomer",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),

                        Text(
                          "Kota",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          controller: kotaController,
                          decoration: InputDecoration(
                            labelText: "Kota",
                            hintText: "Kota",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: Color(0xffaec6cf),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.blue[100],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Icon(Icons.shield),
                            Expanded(
                              child: Text(
                                "Data Anda dan hewan peliharaan Anda aman bersama Kami. Kami menghargai privasi dan keamanan Anda",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black, width: 1),
                        backgroundColor: Color(0xFFaec6cf),
                      ),

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Sudah memenuhi syarat");

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Berhasil"),

                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Anda berhasil membuat Akun, Selamat Datang ! ${emailController.text}",
                                  ),
                                ],
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePage2(
                                          email: emailController.text,
                                          kota: kotaController.text,
                                        ),
                                      ),
                                    );
                                  },

                                  child: Text("Lanjutkan"),
                                ),
                              ],
                            ),
                          );
                        } else {
                          print(emailController.text);

                          Fluttertoast.showToast(
                            msg: "Silakan periksa kembali",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Daftar",
                            style: TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 16,
                            ),
                          ),

                          Icon(
                            Icons.arrow_right_alt_sharp,
                            color: Color(0xFF777777),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Sudah punya akun? ",
                        style: TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushNamed(context, '/signin'),
                            text: "Masuk di sini",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
