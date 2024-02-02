part of 'web_view_bloc.dart';

sealed class WebViewEvent extends Equatable {
  const WebViewEvent();

  @override
  List<Object> get props => [];
}

class WebViewEventOnInitial extends WebViewEvent {
  const WebViewEventOnInitial();
}

class WebViewEventOnLoading extends WebViewEvent {
  final double progress;
  const WebViewEventOnLoading({this.progress = 0.0});
}

class WebViewEventOnLoaded extends WebViewEvent {
  const WebViewEventOnLoaded();
}

class WebViewEventOnError extends WebViewEvent {
  final String errorMessage;
  const WebViewEventOnError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
