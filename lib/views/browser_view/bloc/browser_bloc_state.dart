part of 'browser_bloc.dart';

sealed class BrowserBlocState extends Equatable {
  final bool isShowingWebView;
  const BrowserBlocState({required this.isShowingWebView});

  @override
  List<Object> get props => [isShowingWebView];
}

class BrowserBlocStateInitial extends BrowserBlocState {
  const BrowserBlocStateInitial({required bool isShowingWebView})
      : super(isShowingWebView: isShowingWebView);
}
