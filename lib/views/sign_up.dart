import 'package:flutter/material.dart';
import 'log_in.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // هنا مكان اللوجو
              Icon(Icons.restaurant_menu, size: 100, color: Colors.orange),
              
              SizedBox(height: 10),
              Text("نَهَم", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.orange[800])),
              SizedBox(height: 60),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size(280, 55), backgroundColor: Colors.orange),
                onPressed: () {},
                child: Text("طباخ (Cook)", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 15),
              
              OutlinedButton(
                style: OutlinedButton.styleFrom(fixedSize: Size(280, 55), side: BorderSide(color: Colors.orange)),
                onPressed: () {},
                child: Text("عميل (Customer)", style: TextStyle(fontSize: 18, color: Colors.orange)),
              ),
              
              SizedBox(height: 40),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("لديك حساب بالفعل؟ "),
                  GestureDetector(
                    onTap: () {
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("تسجيل الدخول", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}