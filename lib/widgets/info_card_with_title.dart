import 'package:flutter/material.dart';

class InfoCardWithTitle extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? functionButton;

  const InfoCardWithTitle({
    super.key,
    required this.title,
    required this.child,
    this.functionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                if (functionButton != null) functionButton!,
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          child,
        ],
      ),
    );
  }
}
