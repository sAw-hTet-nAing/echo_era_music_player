import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'browser_bloc_event.dart';
part 'browser_bloc_state.dart';

class BrowserBloc extends Bloc<BrowserBlocEvent, BrowserBlocState> {
  BrowserBloc()
      : super(const BrowserBlocStateInitial(isShowingWebView: false)) {
    on<BrowserBlocEvent>((event, emit) {
      if (event is BrowserBlocEventOnSearch) {
        emit(BrowserBlocStateInitial(isShowingWebView: event.isShowingWebView));
      }
    });
  }
}
