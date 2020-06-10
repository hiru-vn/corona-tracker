
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:corona_tracker/base_config/base_config.dart';

abstract class BaseBloc {
  AppBloc appBloc;

  final StreamController<BaseEvent> _processEventSubject =
      BehaviorSubject<BaseEvent>();

  final StreamController<bool> _loadingStreamController =
      StreamController<bool>();

  final StreamController<bool> _endScrollStreamController =
      StreamController<bool>();

  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  Stream<bool> get loadingStream => _loadingStreamController.stream;
  Sink<bool> get loadingSink => _loadingStreamController.sink;

  Stream<bool> get endScrollStream => _endScrollStreamController.stream;
  Sink<bool> get endScrollSink => _endScrollStreamController.sink;

  Stream<BaseEvent> get processEventStream => _processEventSubject.stream;
  Sink<BaseEvent> get processEventSink => _processEventSubject.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Invalid event");
      }

      dispatchEvent(event);
    });
  }

  void add(BaseEvent event) {
    _eventStreamController.sink.add(event);
  }

  void injectBloc(AppBloc bloc) {
    appBloc = bloc;
    appBloc.appStream.listen((event) {
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  void emit(BaseEvent event) {
    if (appBloc == null) {
      throw Exception('App bloc is not initilized');
    }
    appBloc.appSink.add(event);
  }

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
    _loadingStreamController.close();
    _processEventSubject.close();
    _endScrollStreamController.close();
  }
}
