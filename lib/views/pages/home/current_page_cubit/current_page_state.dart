part of 'current_page_cubit.dart';

class CurrentPageState extends Equatable {
  final int currentPageIndex;

  const CurrentPageState({
    required this.currentPageIndex,
  });

  factory CurrentPageState.initial() => const CurrentPageState(
        currentPageIndex: 0,
      );

  @override
  List<Object> get props => [currentPageIndex];

  @override
  bool get stringify => true;

  CurrentPageState copyWith({
    int? currentPageIndex,
  }) {
    return CurrentPageState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}
