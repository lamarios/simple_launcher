// This file is "main.dart"
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';

part 'letter_list.freezed.dart';

class LetterListCubit extends Cubit<LetterListState> {
  final AppListCubit appListCubit;

  LetterListCubit(super.initialState, this.appListCubit);

  setIndex(int? index, String letter, double? xOffset,
      {bool fromInvisible = false}) {
    emit(state.copyWith(
        index: index, xOffset: xOffset?.abs(), fromInvisible: fromInvisible));
    if (index != null) {
      appListCubit.setLetterFilter(index == 0 ? null : letter);
    }
  }
}

@freezed
class LetterListState with _$LetterListState {
  const factory LetterListState(
      {int? index,
      double? xOffset,
      @Default(false) bool fromInvisible}) = _LetterListState;
}
