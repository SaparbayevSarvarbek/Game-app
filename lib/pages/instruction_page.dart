import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yo\'riqnoma',
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ushbu mobil ilova foydalanuvchining yoshiga qarab test sinovlarini taqdim etadi.',
                style: TextStyle(fontSize: 18.sp),
                textAlign: TextAlign.start,
              ),
              Text(
                'Foydalanish tartibi',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Text('1. Ro\'yhatdan o\'ting ',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('2. O\'zingizga mos yosh toyifasini tanlang',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('3. Test ishlashni boshlang',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('4. Test natijasini bilib oling',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Baholash tartibi',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Text(
                  'Baholar siz vazifani qancha vaqtda bajarishigizga qarab belgilanadi va  yosh kategoriyasiga qarab o\'zgaradi. Vazifalar sizga rasm yoki gif formatida ko\'rsatiladi  shu vazifani bajarib bo\'lib keyingi vazifaga o\'tishinigz mumkin.',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('Baholar turlari',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('   1. Zo\'r',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('   2. O\'rtacha',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
              Text('   3. Yomon',
                  style: TextStyle(
                    fontSize: 16.sp,
                  )),
            ],
          )),
    );
  }
}
