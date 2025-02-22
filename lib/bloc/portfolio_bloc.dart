import 'package:flutter_bloc/flutter_bloc.dart';

import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(PortfolioState(isDarkMode: true)) {
    on<ToggleTheme>((event, emit) {
      emit(PortfolioState(isDarkMode: !state.isDarkMode));
    });
  }
}
