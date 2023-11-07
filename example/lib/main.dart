import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

const int STEPS = 3;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Step Indicator Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StepIndicatorPageViewDemo(
        pageController: PageController(),
      ),
    );
  }
}

class StepIndicatorPageViewDemo extends StatefulWidget {
  const StepIndicatorPageViewDemo({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  _StepIndicatorPageViewDemoState createState() =>
      _StepIndicatorPageViewDemoState();
}

class _StepIndicatorPageViewDemoState extends State<StepIndicatorPageViewDemo> {
  int initialPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: initialPage,
      viewportFraction: 0.9,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (initialPage == 0) {
        pageController.jumpToPage(1);
        //pageController.jumpTo(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: StepIndicatorPageView(
                physics: NeverScrollableScrollPhysics(),
                steps: STEPS,
                indicatorPosition: IndicatorPosition.top,
                controller: pageController,
                complete: () {
                  //typically, you'd want to put logic that returns true when all the steps
                  //are completed here
                  return Future.value(true);
                },
                children: List<Widget>.generate(
                  STEPS,
                  (index) => Container(
                    color: Color(0xffffffff),
                    child: Center(
                      child: Text(
                        "Page ${index}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (pageController.page == 1) {
                          pageController.jumpToPage(2);
                        } else if (pageController.page == 2) {
                          pageController.jumpToPage(3);
                        }
                      },
                      child: const Text('Continue')),
                ))
          ],
        ),
      ),
    );
  }
}
