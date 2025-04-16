import 'package:flutter/material.dart';

final class EmptyStateView extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyStateView({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // İçeriğin kapladığı kadar yer alır
        children: [
          Icon(
            icon,
            size: 80.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
