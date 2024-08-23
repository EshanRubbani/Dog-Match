// lib/widgets/language_switcher.dart
import 'package:DogMatch/Helper/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSwitcher extends StatefulWidget {
  @override
  _LanguageSwitcherState createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  double _currentSliderValue = 0;

  final List<Map<String, String>> _supportedLanguages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Spanish', 'code': 'es'},
    {'name': 'French', 'code': 'fr'},
    {'name': 'German', 'code': 'de'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Text(
          'Select Language: ${_supportedLanguages[_supportedLanguages.indexWhere((lang) => lang['code'] == Constants.language)]['name']}',
          style: TextStyle(fontSize: 18),
        )),
        Slider(
          value: _supportedLanguages.indexWhere((lang) => lang['code'] == Constants.language).toDouble(),
          min: 0,
          max: (_supportedLanguages.length - 1).toDouble(),
          divisions: _supportedLanguages.length - 1,
          label: _supportedLanguages[_currentSliderValue.toInt()]['name'],
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              Constants.language = _supportedLanguages[_currentSliderValue.toInt()]['code']!;
            });
          },
        ),
      ],
    );
  }
}
