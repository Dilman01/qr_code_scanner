class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Welcome!',
      image: 'assets/images/qr_code1.jpg',
      description:
          ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  OnboardingContent(
      title: 'Scan Anywhere!',
      image: 'assets/images/qr_code2.png',
      description:
          ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  OnboardingContent(
      title: 'Get Started Now!',
      image: 'assets/images/qr_code3.jpg',
      description:
          ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
];
