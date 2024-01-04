import 'package:flutter/material.dart';
import 'package:shop_app/Screens/login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Shared/components/components.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final indicatorController =
      PageController(viewportFraction: 1, keepPage: true);

  final counter = 3;

  final List<BoardingModel> models = [
    BoardingModel(
        image: 'assets/onBoarding_1.jpg',
        title: 'Screen Title 1',
        body: 'Screen Body 1'),
    BoardingModel(
        image: 'assets/onBoarding_1.jpg',
        title: 'Screen Title 2',
        body: 'Screen Body 2'),
    BoardingModel(
        image: 'assets/onBoarding_1.jpg',
        title: 'Screen Title 3',
        body: 'Screen Body 3')
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          defaultTextButton(
            text: 'Skip',
            function: () {
              pushReplace(context, Login());
            },
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: indicatorController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(models[index]),
                itemCount: models.length,
                onPageChanged: (index) {
                  if (index == models.length - 1) {
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
            SmoothPageIndicator(
              controller: indicatorController,
              count: counter,
              effect: WormEffect(
                  type: WormType.thin, activeDotColor: Colors.cyan.shade400),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isLast) {
            pushReplace(context, Login());
          }
          indicatorController.nextPage(
              duration: const Duration(milliseconds: 750),
              curve: Curves.fastLinearToSlowEaseIn);
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(model.image),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              model.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              model.body,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
