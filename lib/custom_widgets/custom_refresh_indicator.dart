// custom_refresh_indicator.dart

import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;

  // ignore: use_super_parameters
  const CustomRefreshIndicator({Key? key, required this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.blueAccent, // Customize the refresh indicator color
      displacement: 40, // Adjust the distance of the indicator
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(); // Placeholder for list items, to be replaced with actual items
        },
      ),
    );
  }
}
