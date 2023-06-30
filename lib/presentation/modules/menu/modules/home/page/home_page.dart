import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';

import '../../../../../../data/repository_impl/api_repository/dart_io_api_repository_impl.dart';
import '../../../../../../data/repository_impl/home_repository_impl.dart';
import '../../../../../widgets/failed_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../chart/presentation/chart_page.dart';
import '../bloc/bloc.dart';
import '../widget/home_balance_widget.dart';
import '../widget/home_list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = HomeBloc(
      repository: HomeRepositoryImpl(
        apiRepository: DartIOApiRepositoryImpl.instance,
      ),
    )..load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Portofolio',
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 24,
          ),
        ),
        backgroundColor: context.canvasColor,
        elevation: 0,
      ),
      body: BlocProvider<HomeBloc>(
        create: (context) => _homeBloc,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is HomeFailedState) {
            return FailedWidget(
              message: state.message,
              onReload: () async => await context.read<HomeBloc>().load(),
            );
          } else if (state is HomeSucsessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          HomeBalanceWidget(
                            colors: [
                              Color.fromRGBO(180, 112, 255, 1),
                              Color.fromRGBO(130, 184, 255, 1),
                            ],
                          ),
                          HomeBalanceWidget(
                            colors: [
                              Color.fromRGBO(228, 86, 132, 1),
                              Color.fromRGBO(231, 195, 207, 1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chart',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.disabledColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'See All',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.from(
                          state.data.map(
                            (e) => HomeListItemWidget(
                              data: e,
                              onTap: (symbol) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChartPage(symbol: symbol),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
