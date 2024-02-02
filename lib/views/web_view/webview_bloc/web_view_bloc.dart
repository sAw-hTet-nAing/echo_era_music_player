import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'web_view_event.dart';
part 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(const WebViewInitial()) {
    on<WebViewEvent>((event, emit) {
      if (event is WebViewEventOnLoading) {
        emit(const WebViewLoading());
      } else if (event is WebViewEventOnLoaded) {
        emit(const WebViewLoaded());
      } else if (event is WebViewEventOnError) {
        emit(WebViewError(message: event.errorMessage));
      }
    });
  }
}
