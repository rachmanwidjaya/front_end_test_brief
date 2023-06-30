import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

abstract class WssState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WssInitialState extends WssState {}

class WssLoadingState extends WssState {}

class WssClosedState extends WssState {}

class WssFailedState extends WssState {
  final String message;
  WssFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}

class WssSucsessState extends WssState {
  final String data;
  WssSucsessState({required this.data});
  @override
  List<Object?> get props => [data];
}

class WssBloc extends Cubit<WssState> {
  final List<String> actions = [];
  WssBloc() : super(WssInitialState());
  late IOWebSocketChannel channel;

  Future<void> load() async {
    emit(WssLoadingState());
    _openWs();
  }

  _openWs() async {
    try {
      channel = IOWebSocketChannel.connect(
        Uri.parse(
            'wss://ws.eodhistoricaldata.com/ws/forex?api_token=OeAFFmMliFG5orCUuwAKQ8l4WWFQ67YX'),
      );
    } catch (e, s) {
      emit(WssFailedState(message: 'Failed To Connect Stream'));
      log('$e', error: e, stackTrace: s);
    }
    log('Open Stream');
    await Future.delayed(const Duration(seconds: 3));
    await _listenStream();
  }

  _listenStream() {
    try {
      for (String element in actions) {
        channel.sink.add(element);
      }
      channel.stream.listen(
        (event) async {
          try {
            log('$event', name: 'WssEvent');
            emit(WssSucsessState(data: '$event'));
          } catch (e, s) {
            log('$e', error: e, stackTrace: s);
          }
        },
        onDone: () {
          emit(WssFailedState(message: 'Stream channel closed'));
          log('Stream CLosed', name: '_listenStream');
          _openWs();
        },
        onError: (error) {
          emit(WssFailedState(message: '$error'));
          log('$error', name: '_listenStream');
          _openWs();
        },
      );
    } catch (_) {}
  }
}
