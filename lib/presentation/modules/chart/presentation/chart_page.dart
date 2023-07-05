import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';
import 'package:forex_imf_tes/utils/extensions/double_extension.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../data/repository_impl/api_repository/dart_io_api_repository_impl.dart';
import '../../../../data/repository_impl/chart_repository_impl.dart';
import '../../../../utils/ab_chart/ab_chart.dart';
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
                              Expanded(
                                child: Text(
                                  state.data.last.dc,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontSize: 24,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  state.data.last.dd,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontSize: 24,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                          child: AbChartWidget(
                            datas: state.data,
                            lineWidth: 1.5,
                            fractionDigits:
                                state.data.last.a.getDecimalLength(),
                            padding: const EdgeInsets.all(8),
                            chartStyle: AbChartStyle(
                              // gridRows: 10, gridColumns: 10,
                              // gridColumns: state.data.take(10).length,
                              // candleWidth: 1,
                              // candleLineWidth: 0.5,
                              pointWidth: 1,
                            ),
                            chartColors: AbChartColors(
                              aLineColor: AppColors.instance.primaryColor,
                              aPriceColor: Colors.white,
                              bLineColor: Colors.blue,
                              bPriceColor: Colors.white,
                            ),
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
