part of 'browser_bloc.dart';

sealed class BrowserBlocEvent extends Equatable {
  const BrowserBlocEvent();

  @override
  List<Object> get props => [];
}

class BrowserBlocEventOnSearch extends BrowserBlocEvent {
  final bool isShowingWebView;

  const BrowserBlocEventOnSearch({required this.isShowingWebView});
}
