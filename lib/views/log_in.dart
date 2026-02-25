import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // زر الرجوع للخلف تلقائي بيطلع في الـ AppBar
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent, iconTheme: IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(          
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("تسجيل الدخول", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("أهلاً بك مجدداً في نهم", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 40),
              
              TextField(decoration: InputDecoration(labelText: "اسم المستخدم / الإيميل", border: OutlineInputBorder())),
              SizedBox(height: 20),
              TextField(obscureText: true, decoration: InputDecoration(labelText: "كلمة المرور", border: OutlineInputBorder())),
              
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 55), backgroundColor: Colors.black),
                onPressed: () {
                  // هنا مستقبلاً بيتم التحقق من البيانات
                }, 
                child: Text("دخول", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}