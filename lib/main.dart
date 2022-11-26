import 'package:cupertino_store/model/app_state_model.dart';
import 'package:cupertino_store/model/products_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel(productRepository: DefaultProductsRepository())..loadProducts(),
      child: const CupertinoStoreApp()
    )
  );
}