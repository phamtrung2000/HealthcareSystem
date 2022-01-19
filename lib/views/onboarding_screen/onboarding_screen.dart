import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/authentication/authentication_screen.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_mental_health/views/menu_screen/widgets/default_button.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  static const id = "OnboardingScreen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (v) => setState(() {
                selectedIndex = v;
              }),
              itemCount: 4,
              itemBuilder: (context, index) {
                if (selectedIndex != 3) {
                  return Lottie.asset(
                    onboardingData[selectedIndex]['image'].toString(),
                    height: 300,
                  );
                } else {
                  return Container(
                    color: AppColors.kOnboardingPageColor,
                    child: Lottie.asset(
                      onboardingData[selectedIndex]['image'].toString(),
                    ),
                  );
                }
              },
            ),
          ),
          (selectedIndex != 3)
              ? Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.kOnboardingPageColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        onboardingData[selectedIndex]['title'].toString(),
                        style: TextConfigs.kText36w700White,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DefaultButton(
                          color: AppColors.kPopupBackgroundColor,
                          onTap: () {},
                          title: onboardingData[selectedIndex]['content']
                              .toString(),
                          titleStyle: TextConfigs.kText18w400Black,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                  color: AppColors.kOnboardingPageColor,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.kPopupBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            onboardingData[selectedIndex]['content'].toString(),
                            style: TextConfigs.kText18w400Black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: DefaultButton(
                            color: AppColors.kButtonColor,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AuthenticationScreen()),
                              );
                            },
                            title: 'Start',
                            titleStyle: TextConfigs.kText16w400White,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            color: AppColors.kOnboardingPageColor,
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => buildIndicators(index)),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildIndicators(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: index == selectedIndex ? 16.0 : 8.0,
      width: index == selectedIndex ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: index == selectedIndex ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      duration: const Duration(milliseconds: 200),
    );
  }
}

const onboardingData = [
  {
    'image': 'assets/images/onboarding-1.json',
    'title': 'Title1',
    'content': 'content1',
  },
  {
    'image': 'assets/images/onboarding-2.json',
    'title': 'Title2',
    'content': 'content2',
  },
  {
    'image': 'assets/images/onboarding-3.json',
    'title': 'Title3',
    'content': 'content3'
  },
  {
    'image': 'assets/images/onboarding-4.json',
    'title': 'Title4',
    'content': 'content4'
  },
];

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    Key? key,
    required this.imagePath,
    required this.content,
    this.child,
  }) : super(key: key);
  final String imagePath;
  final String content;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(imagePath);
  }
}
