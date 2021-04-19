import 'package:flutter/material.dart';

class Reusablecard extends StatelessWidget {
  Reusablecard({this.colour, this.cardchild});

  final Color colour;
  final Widget cardchild;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        color: colour,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: cardchild,
    );
  }
}
