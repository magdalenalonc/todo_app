import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ToDoEntryItemLoading extends StatelessWidget {
  const ToDoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Colors.deepOrange,
      colorOpacity: 0.4,
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        margin: const EdgeInsets.all(0),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 100,
            minWidth: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
      ),
    );
  }
}
