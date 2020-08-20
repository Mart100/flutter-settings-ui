import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings_ui/src/cupertino_settings_item.dart';

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Widget leading;
  final Widget trailing;
  final VoidCallback onTap;
  final Function(bool value) onToggle;
  final bool switchValue;
  final bool enabled;
  final Color switchActiveColor;
  final _SettingsTileType _tileType;

  const SettingsTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.switchActiveColor,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = null,
        super(key: key);

  const SettingsTile.switchTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.trailing,
    @required this.onToggle,
    @required this.switchValue,
    this.switchActiveColor,
  })  : _tileType = _SettingsTileType.switchTile,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isIOS) {
      return iosTile();
    } else {
      return androidTile();
    }
  }

  Widget iosTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.toggle,
        label: title.data,
        leading: leading,
        switchValue: switchValue,
        onToggle: onToggle,
        labelTextStyle: title.style,
        switchActiveColor: switchActiveColor,
        subtitleTextStyle: subtitle.style,
        valueTextStyle: subtitle.style,
      );
    } else {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.modal,
        label: title.data,
        value: subtitle.data,
        trailing: trailing,
        hasDetails: false,
        leading: leading,
        onPress: onTap,
        labelTextStyle: title.style,
        subtitleTextStyle: subtitle.style,
        valueTextStyle: subtitle.style,
      );
    }
  }

  Widget androidTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return SwitchListTile(
        secondary: leading,
        value: switchValue,
        activeColor: switchActiveColor,
        onChanged: enabled ? onToggle : null,
        title: title,
        subtitle: subtitle,
      );
    } else {
      return ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        enabled: enabled,
        trailing: trailing,
        onTap: onTap,
      );
    }
  }
}
