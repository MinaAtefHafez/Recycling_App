// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeItem extends StatelessWidget {
  final String text;
  final String urlImage;
  final Function() onTap;
  HomeItem({required this.text, required this.urlImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: mq.size.width > 600 ? mq.size.height *0.35 :  mq.size.height * 0.28,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: mq.size.width > 600 ? 85 : 70,
                  height: mq.size.width > 600 ? 85 : 70,
                  child: Image.asset(urlImage),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: GoogleFonts.balooBhaina(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                    fontSize: mq.size.width > 600 ? mq.size.height *0.038 : mq.size.height * 0.023  ,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
