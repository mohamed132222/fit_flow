import 'package:equatable/equatable.dart';

import '../error/failures.dart';

enum ViewStatus { initial, loading, success, failure }

class ViewState<T> extends Equatable {
  const ViewState({this.status = ViewStatus.initial, this.data, this.failure});

  final ViewStatus status;
  final T? data;
  final Failure? failure;

  bool get isInitial => status == ViewStatus.initial;
  bool get isLoading => status == ViewStatus.loading;
  bool get isSuccess => status == ViewStatus.success;
  bool get isFailure => status == ViewStatus.failure;

  ViewState<T> copyWith({
    ViewStatus? status,
    T? data,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return ViewState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [status, data, failure];
}
