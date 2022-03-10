import 'package:flutter/material.dart';

class FavIconButton extends StatelessWidget {
  final IconData iconData;
  final int? notificationCount;

  const FavIconButton({
    Key? key,
    required this.iconData,
    this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(iconData),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                alignment: Alignment.center,
                child: Text('$notificationCount',
                    style: const TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}