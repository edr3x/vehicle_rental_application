import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'current_page_state.dart';

class CurrentPageCubit extends Cubit<CurrentPageState> {
  CurrentPageCubit() : super(CurrentPageState.initial());

  void setCurrentPageIndex(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }
}
