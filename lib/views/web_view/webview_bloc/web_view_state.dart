part of 'web_view_bloc.dart';

sealed class WebViewState extends Equatable {
  const WebViewState();

  @override
  List<Object> get props => [];
}

class WebViewInitial extends WebViewState {
  const WebViewInitial();

  @override
  List<Object> get props => [];
}

class WebViewLoading extends WebViewState {
  final double progress;
  const WebViewLoading({this.progress = 0.0});

  @override
  List<Object> get props => [progress];
}

class WebViewLoaded extends WebViewState {
  const WebViewLoaded();

  @override
  List<Object> get props => [];
}

class WebViewError extends WebViewState {
  final String message;
  const WebViewError({required this.message});

  @override
  List<Object> get props => [message];
}
