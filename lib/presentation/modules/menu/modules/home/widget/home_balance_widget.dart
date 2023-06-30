import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';

class HomeBalanceWidget extends StatelessWidget {
  final List<Color> colors;
  const HomeBalanceWidget({
    super.key,
    this.colors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: context.sizeWidth / 1.2,
        height: (context.sizeWidth) / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ 49,392.77',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.blur_circular_outlined,
                  color: Colors.white,
                )
              ],
            ),
            Text(
              'Your balance is equivalent',
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: ThemeData.dark().disabledColor),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Card(
                  color: Colors.white.withOpacity(0.1),
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      'Deposit',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: ThemeData.dark().disabledColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.1),
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      'Withdraw',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: ThemeData.dark().disabledColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
