import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../data/repository_impl/api_repository/dart_io_api_repository_impl.dart';
import '../../../../data/repository_impl/chart_repository_impl.dart';
import '../../../../domain/entities/chart_candle_entity.dart';
import '../../../bloc/wss_bloc.dart';
import '../../../widgets/failed_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/wss_state_widget.dart';
import '../bloc/chart_bloc.dart';

class ChartPage extends StatefulWidget {
  final String symbol;
  const ChartPage({
    super.key,
    required this.symbol,
  });

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late ChartBloc _chartBloc;
  late WssBloc _wssBloc;
  final String action = '{"action": "subscribe", "symbols": "EURUSD"}';
  @override
  void initState() {
    _chartBloc = ChartBloc(
      repository: ChartRepositoryImpl(
        apiRepository: DartIOApiRepositoryImpl.instance,
      ),
    )..load(
        widget.symbol,
        onReady: () => context.read<WssBloc>().channel.sink.add(action),
      );
    context.read<WssBloc>().actions.add(action);
    super.initState();
  }

  @override
  void dispose() {
    _wssBloc.actions.removeWhere((element) => element == action);
    _wssBloc.channel.sink.add('{"action": "unsubscribe", "symbols": "EURUSD"}');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _wssBloc = context.read<WssBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartBloc>(
      create: (_) => _chartBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.symbol,
            style: context.textTheme.bodyLarge,
          ),
          backgroundColor: context.canvasColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left,
              size: 32,
            ),
          ),
        ),
        body: Stack(
          children: [
            BlocBuilder<ChartBloc, ChartState>(
              builder: (context, state) {
                if (state is ChartLoadingState) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }
                if (state is ChartFailedState) {
                  return FailedWidget(
                    message: state.message,
                    onReload: () async =>
                        await context.read<ChartBloc>().load(widget.symbol),
                  );
                }
                if (state is ChartSuccsesState) {
                  return BlocListener<WssBloc, WssState>(
                    listenWhen: (previous, current) =>
                        current is WssSucsessState,
                    listener: (context, state) => context
                        .read<ChartBloc>()
                        .manageStream((state as WssSucsessState).data),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Instant Execution',
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(8)),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('-0.1'),
                            Text('-0.01'),
                            Text('0.10'),
                            Text('+0.01'),
                            Text('+0.1'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              _item('Stop Loss'),
                              _item('Take Profit'),
                              _item('Deviation'),
                            ],
                          ),
                        ),
                        Container(
                          color: context.cardColor,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                state.data.last.dc,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                state.data.last.dd,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              color: context.primaryColor,
                              width: context.sizeWidth / 2,
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  'Sell',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: AppColors.instance.sucsessDefault,
                              width: context.sizeWidth / 2,
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  'Buy',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              SfCartesianChart(
                                margin:
                                    const EdgeInsets.only(right: 14, top: 10),
                                plotAreaBorderWidth: 0,
                                primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  isVisible: false,
                                  minimum: 0,
                                  maximum: 700,
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: true,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  decimalPlaces: 4,
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  labelAlignment: LabelAlignment.end,
                                  opposedPosition: true,
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  maximum: state.maxValue,
                                  minimum: state.minValue,
                                ),
                              ),
                              SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  isVisible: false,
                                  minimum: 0,
                                  maximum: 700,
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                  decimalPlaces: 4,
                                  labelAlignment: LabelAlignment.end,
                                  opposedPosition: true,
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  maximum: state.maxValue,
                                  minimum: state.minValue,
                                ),
                                series: [
                                  ///A
                                  LineSeries<ChartCandleEntity, double>(
                                    color: context.primaryColor,
                                    animationDuration: 0,
                                    dataSource: state.data,
                                    xValueMapper:
                                        (ChartCandleEntity _, index) =>
                                            index.toDouble(),
                                    yValueMapper: (ChartCandleEntity data, _) =>
                                        data.a,
                                    width: 1,
                                  ),
                                  LineSeries<dynamic, dynamic>(
                                    color: context.primaryColor,
                                    animationDuration: 0,
                                    width: 1,
                                    dataSource: [
                                      [state.data.length, state.data.last.a],
                                      [
                                        state.data.length + 130,
                                        state.data.last.a
                                      ],
                                    ],
                                    xValueMapper: (dynamic candleData, _) =>
                                        candleData[0],
                                    yValueMapper: (dynamic candleData, _) =>
                                        candleData[1],
                                  ),
                                  LineSeries<dynamic, dynamic>(
                                    animationDuration: 0,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                      color: context.primaryColor,
                                      labelAlignment:
                                          ChartDataLabelAlignment.middle,
                                      labelPosition:
                                          ChartDataLabelPosition.outside,
                                    ),
                                    color: context.primaryColor,
                                    width: 1,
                                    dataSource: [
                                      [
                                        state.data.length + 200,
                                        state.data.last.a
                                      ],
                                    ],
                                    xValueMapper: (dynamic candleData, _) =>
                                        candleData[0],
                                    yValueMapper: (dynamic candleData, _) =>
                                        candleData[1],
                                  ),

                                  ///B
                                  LineSeries<ChartCandleEntity, double>(
                                    color: AppColors.instance.sucsessDefault,
                                    animationDuration: 0,
                                    dataSource: state.data,
                                    xValueMapper:
                                        (ChartCandleEntity _, index) =>
                                            index.toDouble(),
                                    yValueMapper: (ChartCandleEntity data, _) =>
                                        data.b,
                                    width: 1,
                                  ),
                                  LineSeries<dynamic, dynamic>(
                                    color: AppColors.instance.sucsessDefault,
                                    width: 1,
                                    animationDuration: 0,
                                    dataSource: [
                                      [state.data.length, state.data.last.b],
                                      [
                                        state.data.length + 130,
                                        state.data.last.b
                                      ],
                                    ],
                                    xValueMapper: (dynamic candleData, _) =>
                                        candleData[0],
                                    yValueMapper: (dynamic candleData, _) =>
                                        candleData[1],
                                  ),
                                  LineSeries<dynamic, dynamic>(
                                    animationDuration: 0,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                      color: AppColors.instance.sucsessDefault,
                                      labelAlignment:
                                          ChartDataLabelAlignment.middle,
                                      labelPosition:
                                          ChartDataLabelPosition.outside,
                                    ),
                                    color: context.primaryColor,
                                    width: 1,
                                    dataSource: [
                                      [
                                        state.data.length + 200,
                                        state.data.last.b
                                      ],
                                    ],
                                    xValueMapper: (dynamic candleData, _) =>
                                        candleData[0],
                                    yValueMapper: (dynamic candleData, _) =>
                                        candleData[1],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const Positioned(
              bottom: 0,
              child: WssStateWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: context.sizeWidth / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Expanded(
                      child: Text(
                        '-',
                        textAlign: TextAlign.end,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'not set',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: context.disabledColor),
                        ),
                      ),
                    ),
                    Text(
                      '+',
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(4)),
        ],
      );
}
