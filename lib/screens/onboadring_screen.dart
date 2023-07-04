// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:qr_code_scanner/main.dart';
import '../models/onboarding_content_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  bool isLastPage = false;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == contents.length - 1;
                });
              },
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 40, left: 40, right: 40),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[index].image,
                        height: 250,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        contents[index].title,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        contents[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: contents.length,
            onDotClicked: (index) => _controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
            effect: WormEffect(
              spacing: 14,
              dotColor: Colors.black26,
              activeDotColor: Colors.orange.shade800,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                foregroundColor: Colors.white,
              ),
              child: Text(isLastPage ? "Let's Get Started" : "Next"),
              onPressed: () async {
                if (isLastPage) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MyHome(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
