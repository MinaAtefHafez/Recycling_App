// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:recycling/helper/cache_helper.dart';
import 'package:recycling/utils/constants.dart';
import 'package:recycling/view/screens/auth/login_screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String? image;
  String? title;
  String? body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding1.jpg',
        title: 'Recycling App',
        body:
            'It is an application to sort waste materials by type and sell them to us sorted in exchange for some of the services that we will provide to you'),
    BoardingModel(
        image: 'assets/images/on_boarding2.jpg',
        title: 'Application features',
        body:
            'Providing rewards in the form of points to exchange them for useful things, and facilitating the sorting process for merchants'),
    BoardingModel(
        image: 'assets/images/on_boarding3.jpg',
        title: 'How to use the application',
        body:
            'You will choose the size of each bag of each item and the number of bags as well and then you will send an order, then the order details page will appear '),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], mq.size.width),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                  dotColor: Colors.grey.shade300,
                  activeDotColor: Colors.green.shade400,
                  expansionFactor: 3,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  spacing: 5.0),
            ),
            SizedBox(
              height: 55.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      CacheHelper.saveData(key: 'onBoarding', value: true);
                      navigateAndFinish(context, LoginScreen());
                    },
                    child: Container(
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade500,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                          child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.grey.shade700),
                      )),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      if (isLast) {
                        CacheHelper.saveData(key: 'onBoarding', value: true);
                        navigateAndFinish(context, LoginScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: isLast ? 110 : 60,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: isLast
                            ? Text(
                                'continue',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model, double width) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Center(
                child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.cover,
            )),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model.title}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Text(
                    '${model.body}',
                    style: TextStyle(
                        fontSize: width > 600 ? 18 : 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
