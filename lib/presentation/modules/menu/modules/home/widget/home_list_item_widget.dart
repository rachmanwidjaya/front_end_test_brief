import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';
import 'package:forex_imf_tes/utils/extensions/double_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../domain/entities/candle_entity.dart';
import '../../../../../../domain/entities/currency_entity.dart';
import '../../../../../../utils/helpers/currency_helper.dart';

class HomeListItemWidget extends StatelessWidget {
  final CurrencyEntity data;
  final void Function(String symbol)? onTap;
  const HomeListItemWidget({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color chatColor = data.candles.first.open > data.candles.last.close
        ? context.primaryColor
        : AppColors.instance.sucsessDark;
    return InkWell(
      onTap: () => onTap != null ? onTap!(data.symbol.split('.').first) : {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      height: kBottomNavigationBarHeight,
                      width: kBottomNavigationBarHeight * 2.5,
                      child: SfCartesianChart(
                        margin: const EdgeInsets.all(0),
                        plotAreaBorderWidth: 0,
                        primaryXAxis: NumericAxis(
                          isVisible: false,
                        ),
                        primaryYAxis: NumericAxis(
                          isVisible: false,
                          minimum: data.candles
                              .reduce((a, b) => a.close < b.close ? a : b)
                              .close,
                          maximum: data.candles
                              .reduce((a, b) => a.close > b.close ? a : b)
                              .close,
                        ),
                        series: [
                          AreaSeries<CandleEntity, num>(
                            borderWidth: 1,
                            borderColor: chatColor,
                            dataSource: data.candles,
                            xValueMapper: (CandleEntity candleData, index) =>
                                index,
                            yValueMapper: (CandleEntity candleData, _) =>
                                candleData.close,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                chatColor.withOpacity(0.3),
                                Colors.transparent,
                              ],
                              stops: const [
                                0.1,
                                1.0,
                              ],
                            ),
                          ),
                          LineSeries<CandleEntity, num>(
                            width: 1,
                            color: chatColor,
                            dataSource: data.candles,
                            xValueMapper: (CandleEntity candleData, index) =>
                                index,
                            yValueMapper: (CandleEntity candleData, _) =>
                                candleData.close,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      data.symbol.split('.').first,
                      style: context.textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      CurrencyHelper().calculatePercentage(
                        data.candles.first.open,
                        data.candles.last.close,
                      ),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.disabledColor,
                      ),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${data.candles.last.close.toCurrency()}',
                          style: context.textTheme.bodyLarge,
                        ),
                        Text(
                          data.candles.last.volume.toCurrency(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
