import 'package:flutter/material.dart';

typedef ErrorBuilder = Widget Function(Object? error, StackTrace? stackTrace);
typedef LoadingBuilder = Widget Function();
typedef DataBuilder<T> = Widget Function(BuildContext context, T data);
typedef EmptyBuilder = Widget Function();

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final T? initialData;
  final ErrorBuilder? errorBuilder;
  final LoadingBuilder? waitingBuilder;
  final DataBuilder<T> dataBuilder;
  final EmptyBuilder? emptyBuilder;

  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.dataBuilder,
    this.errorBuilder,
    this.waitingBuilder,
    this.emptyBuilder,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (futureContext, snapshot) {
        if (snapshot.hasError) {
          debugPrintStack(
            stackTrace: snapshot.stackTrace,
            label: snapshot.error.toString(),
          );
          return errorBuilder?.call(snapshot.error, snapshot.stackTrace) ??
              const SizedBox();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingBuilder?.call() ??
              const Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              );
        } else if (snapshot.hasData) {
          return dataBuilder(futureContext, snapshot.data as T);
        } else {
          return emptyBuilder?.call() ?? const SizedBox();
        }
      },
    );
  }
}

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final T? initialData;
  final ErrorBuilder? errorBuilder;
  final LoadingBuilder? waitingBuilder;
  final DataBuilder<T> dataBuilder;
  final EmptyBuilder? emptyBuilder;

  const CustomStreamBuilder({
    super.key,
    required this.stream,
    required this.dataBuilder,
    this.errorBuilder,
    this.waitingBuilder,
    this.emptyBuilder,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (futureContext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingBuilder?.call() ??
              const Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              );
        } else if (snapshot.hasError) {
          debugPrintStack(
            stackTrace: snapshot.stackTrace,
            label: snapshot.error.toString(),
          );
          return errorBuilder?.call(snapshot.error, snapshot.stackTrace) ??
              const SizedBox();
        } else if (snapshot.hasData) {
          return dataBuilder(futureContext, snapshot.data as T);
        } else {
          return emptyBuilder?.call() ?? const SizedBox();
        }
      },
    );
  }
}
