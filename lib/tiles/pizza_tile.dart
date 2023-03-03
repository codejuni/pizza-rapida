import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza_rapida/models/pizza_model.dart';
import 'package:pizza_rapida/pages/home_controller.dart';

class PizzaTile extends StatelessWidget {
  const PizzaTile({
    super.key,
    required this.controller,
    required this.model,
    required this.index,
  });

  final HomeController controller;
  final PizzaModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller.pageController,
      builder: (context, child) {
        double delta = index - controller.currentPage.value;
        double position = delta * size.width * 0.3;
        double absPosition = position.abs();
        double angle = delta * (2 * pi / 5);
        double opacity = (1 - (absPosition / size.width * 4)).clamp(0.0, 1.0);
        double translate = -(position * sin(angle)) * 1.5;

        return Transform.translate(
          offset: Offset(0, translate),
          child: Transform.rotate(
            angle: angle,
            alignment: Alignment.center,
            child: Transform.scale(
              scale: 0.85,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: controller.duration,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            model.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
