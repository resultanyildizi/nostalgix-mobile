part of 'bottom_navbar_cubit.dart';

enum BottomNavbarTab {
  album,
  settings,
}

final class BottomNavbarState extends Equatable {
  const BottomNavbarState({required this.tabOption});

  factory BottomNavbarState.initial() {
    return BottomNavbarState(tabOption: none());
  }

  BottomNavbarState copyWith({Option<BottomNavbarTab>? tabOption}) {
    return BottomNavbarState(tabOption: tabOption ?? this.tabOption);
  }

  final Option<BottomNavbarTab> tabOption;

  int get currentIndex {
    return tabOption.fold(
      () => 0,
      (tab) => BottomNavbarTab.values.indexOf(tab),
    );
  }

  @override
  List<Object> get props => [tabOption];
}
