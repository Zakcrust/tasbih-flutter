import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasbih_flutter/hive_objects/list_dzikir.dart';

abstract class GeneralToolBase {}

class GeneralTool extends GeneralToolBase {
  static final GeneralTool _instance = GeneralTool._internal();

  factory GeneralTool() {
    return _instance;
  }

  static ListDzikir currentListDzikr = ListDzikir(dzikir: []);

  GeneralTool._internal();

  void initData() async {
    var data = await loadData('dzikr_list');
    if (data == "") {
      ListDzikir initDzikir = ListDzikir(dzikir: [
        Dzikir(name: "Subhanallah", count: 0),
        Dzikir(name: "Alhamdulillah", count: 0),
        Dzikir(name: "Lailahaillallah", count: 0),
        Dzikir(name: "Allahuakbar", count: 0)
      ]);
      currentListDzikr = initDzikir;
      saveData('dzikr_list', jsonEncode(initDzikir));
    } else {
      currentListDzikr = ListDzikir.fromJson(jsonDecode(data));
    }
  }

  void showImageDialog(BuildContext context, String imageUrl) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                return child;
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("");
              },
            ),
          ),
        );
      },
    );
  }

  void saveData(String key, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    switch (data.runtimeType) {
      case int:
        localStorage.setInt(key, data);
        break;
      case bool:
        localStorage.setBool(key, data);
        break;
      case double:
        localStorage.setDouble(key, data);
        break;
      case String:
        localStorage.setString(key, data);
        break;
      default:
    }
    if (data.runtimeType is List<String>) {
      localStorage.setStringList(key, data);
    }
    if (kDebugMode) {
      print('data saved,  $key');
    }
  }

  void removeData(String key) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    if (localStorage.get(key) != null) localStorage.remove(key);
  }

  dynamic loadData(String key) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    if (kDebugMode) {
      print('data loaded ${localStorage.get(key)}');
    }
    return localStorage.get(key) ?? "";
  }
}
