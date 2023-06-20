// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$isLoggedInAtom = Atom(name: '_AppStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AppStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$countryListAtom = Atom(name: '_AppStore.countryList');

  @override
  List<CountryData> get countryList {
    _$countryListAtom.reportRead();
    return super.countryList;
  }

  @override
  set countryList(List<CountryData> value) {
    _$countryListAtom.reportWrite(value, super.countryList, () {
      super.countryList = value;
    });
  }

  final _$allUnreadCountAtom = Atom(name: '_AppStore.allUnreadCount');

  @override
  int get allUnreadCount {
    _$allUnreadCountAtom.reportRead();
    return super.allUnreadCount;
  }

  @override
  set allUnreadCount(int value) {
    _$allUnreadCountAtom.reportWrite(value, super.allUnreadCount, () {
      super.allUnreadCount = value;
    });
  }

  final _$isDarkModeAtom = Atom(name: '_AppStore.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  final _$appBarThemeAtom = Atom(name: '_AppStore.appBarTheme');

  @override
  AppBarTheme get appBarTheme {
    _$appBarThemeAtom.reportRead();
    return super.appBarTheme;
  }

  @override
  set appBarTheme(AppBarTheme value) {
    _$appBarThemeAtom.reportWrite(value, super.appBarTheme, () {
      super.appBarTheme = value;
    });
  }

  final _$selectedLanguageAtom = Atom(name: '_AppStore.selectedLanguage');

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  final _$selectedMenuIndexAtom = Atom(name: '_AppStore.selectedMenuIndex');

  @override
  int get selectedMenuIndex {
    _$selectedMenuIndexAtom.reportRead();
    return super.selectedMenuIndex;
  }

  @override
  set selectedMenuIndex(int value) {
    _$selectedMenuIndexAtom.reportWrite(value, super.selectedMenuIndex, () {
      super.selectedMenuIndex = value;
    });
  }

  final _$setLoggedInAsyncAction = AsyncAction('_AppStore.setLoggedIn');

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction
        .run(() => super.setLoggedIn(val, isInitializing: isInitializing));
  }

  final _$setLoadingAsyncAction = AsyncAction('_AppStore.setLoading');

  @override
  Future<void> setLoading(bool value) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(value));
  }

  final _$setDarkModeAsyncAction = AsyncAction('_AppStore.setDarkMode');

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  final _$setLanguageAsyncAction = AsyncAction('_AppStore.setLanguage');

  @override
  Future<void> setLanguage(String aCode, {BuildContext? context}) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(aCode, context: context));
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setAllUnreadCount(int val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setAllUnreadCount');
    try {
      return super.setAllUnreadCount(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedMenuIndex(int val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setSelectedMenuIndex');
    try {
      return super.setSelectedMenuIndex(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isLoading: ${isLoading},
countryList: ${countryList},
allUnreadCount: ${allUnreadCount},
isDarkMode: ${isDarkMode},
appBarTheme: ${appBarTheme},
selectedLanguage: ${selectedLanguage},
selectedMenuIndex: ${selectedMenuIndex}
    ''';
  }
}
