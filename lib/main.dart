import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/appStateModel.dart';

import 'app.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel()..loadProductModels(),
      child: EasyShoppingApp(),
    ),
  );
}
