// This file is "main.dart"
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:senang_launcher/app_list/models/list_style.dart';
import 'package:senang_launcher/db.dart';

part 'settings.freezed.dart';

const dataDaysSettingName = 'data-days';
const horizontalSpacingSettingName = 'horizontal-spacing';
const verticalSpacingSettingName = 'vertical-spacing';
const minFontSizeSettingName = 'min-font-size';
const maxFontSizeSettingName = 'max-font-size';
const lineHeightSettingName = 'line-height';
const tintColorSettingName = 'tint-color';
const colorSettingName = 'color';
const colorOnNotificationSettingName = 'color-on-notification';
const notificationColorSettingName = 'notification-color';
const showSearchSettingName = 'show-search';
const showLetterListSettingName = 'show-letter-list';
const showInvisibleLetterListSettingName = 'show-invisible-letter-list';
const showLetterListOnRightSettingName = 'show-letter-list-on-right';
const showWallPaperSettingName = 'show-wallpaper';
const showAppIconsSettingName = 'show-app-icon';
const showAppNamesSettingName = 'show-app-name';
const blackBackGroundSettingName = 'black-background';
const themeSettingName = 'theme';
const wallpaperBlurSettingName = 'wallpaper-blur';
const useDynamicColorSettingName = 'dynamic-colors';
const listStyleSettingsName = 'app-list-style';
const firstLaunchSettingName = 'first-launch';
const invertTintSettingName = 'invert-tint';
const fontSettingName = 'font';
const boldFontSettingName = 'bold-font';

const wallPaperDimSettingName = 'wall-paper-dim';

class SettingsCubit extends Cubit<SettingsState> {
  late PackageInfo packageInfo;

  SettingsCubit(super.initialState);

  Future<bool> getSettings() async {
    packageInfo = await PackageInfo.fromPlatform();
    final settings = await db.getSettings();
    emit(state.copyWith(settings: settings));
    return state.firstLaunch;
  }

  updateSetting(String name, String value) async {
    print('name $name $value');
    await db.updateSetting(name, value);
    getSettings();
  }

  Future<void> deleteSetting(String settingName) async {
    await db.deleteSetting(settingName);
    getSettings();
  }
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({@Default({}) Map<String, String> settings}) =
      _SettingsState;

  const SettingsState._();

  int get dataDays => int.tryParse(settings[dataDaysSettingName] ?? '7') ?? 7;

  String? get textFont => settings[fontSettingName];

  FontWeight get fontWeight =>
      (bool.tryParse(settings[boldFontSettingName] ?? 'true') ?? true)
          ? FontWeight.bold
          : FontWeight.normal;

  double get horizontalSpacing =>
      double.tryParse(settings[horizontalSpacingSettingName] ?? '25') ?? 15;

  double get verticalSpacing =>
      double.tryParse(settings[verticalSpacingSettingName] ?? '0') ?? 0;

  double get minFontSize =>
      double.tryParse(settings[minFontSizeSettingName] ?? '20') ?? 20;

  double get maxFontSize =>
      double.tryParse(settings[maxFontSizeSettingName] ?? '50') ?? 70;

  double get lineHeight =>
      double.tryParse(settings[lineHeightSettingName] ?? '1') ?? 1;

  Color get color => Color(
      int.tryParse(settings[colorSettingName] ?? '0xFF00C0A2') ?? 0xFF00C0A2);

  bool get tintColor =>
      bool.tryParse(settings[tintColorSettingName] ?? 'true') ?? true;

  bool get invertTint =>
      bool.tryParse(settings[invertTintSettingName] ?? 'false') ?? false;

  Color get notificationColor => Color(
      int.tryParse(settings[notificationColorSettingName] ?? '0xFFFFEB3B') ??
          Colors.yellow.value);

  bool get colorOnNotifications =>
      bool.tryParse(settings[colorOnNotificationSettingName] ?? 'false') ??
      false;

  bool get showSearch =>
      bool.tryParse(settings[showSearchSettingName] ?? 'false') ?? false;

  bool get showWallPaper =>
      bool.tryParse(settings[showWallPaperSettingName] ?? 'false') ?? false;

  double get wallPaperDim =>
      double.tryParse(settings[wallPaperDimSettingName] ?? '0.5') ?? 0.5;

  double get wallpaperBlur =>
      double.tryParse(settings[wallpaperBlurSettingName] ?? '0.0') ?? 0.0;

  bool get showLetterList =>
      bool.tryParse(settings[showLetterListSettingName] ?? 'true') ?? true;

  bool get letterListOnRight =>
      bool.tryParse(settings[showLetterListOnRightSettingName] ?? 'true') ??
      true;

  bool get showInvisibleLetterList =>
      bool.tryParse(settings[showInvisibleLetterListSettingName] ?? 'true') ??
      true;

  bool get showAppIcons =>
      bool.tryParse(settings[showAppIconsSettingName] ?? 'false') ?? false;

  bool get showAppNames =>
      bool.tryParse(settings[showAppNamesSettingName] ?? 'true') ?? true;

  bool get blackBackground =>
      bool.tryParse(settings[blackBackGroundSettingName] ?? 'false') ?? false;

  bool get dynamicColors =>
      bool.tryParse(settings[useDynamicColorSettingName] ?? 'true') ?? true;

  bool get firstLaunch =>
      bool.tryParse(settings[firstLaunchSettingName] ?? 'true') ?? true;

  ThemeMode? get themeMode => ThemeMode.values
      .where((element) => element.name == settings[themeSettingName])
      .firstOrNull;

  ListStyle get listStyle =>
      ListStyle.values
          .where((element) => element.name == settings[listStyleSettingsName])
          .firstOrNull ??
      ListStyle.wrap;
}
