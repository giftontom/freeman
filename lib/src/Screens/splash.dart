import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freeman/src/router_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _taglineAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust duration as needed
    );

    // Create staggered animations for the logo and tagline
    _logoAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5), // Logo animation from 0% to 50% of total duration
    );

    _taglineAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 1.0), // Tagline animation from 50% to 100% of total duration
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // When the animation completes, navigate to the next screen
        Routes.pushReplacementNamed(Routes.splash1);
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.1,
                child: AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value,
                      child: SvgPicture.asset('assets/logo.svg'),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AnimatedBuilder(
                  animation: _taglineAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _taglineAnimation.value,
                      child: SvgPicture.asset('assets/tagline.svg'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
