import 'package:cupertino_store/model/products_repository.dart';
import 'package:cupertino_store/product_list_tab/product_list_tab.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_store/model/app_state_model.dart';
import 'package:flutter_test/flutter_test.dart';


Widget createProductListTab() => ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel(productRepository: DefaultProductsRepository())..loadProducts(),
      child: const CupertinoApp(
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: ProductListTab(),
      ),
    );


  void main() {
  group('Product List Tab Widget Tests', () {
    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createProductListTab());
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
      expect(find.text('Vagabond sack'), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.plus_circled), findsAtLeastNWidgets(1));
      await tester.fling(find.byType(CustomScrollView), const Offset(0, -200), 3000);
      await tester.pumpAndSettle();
      expect(find.text('Vagabond sack'), findsNothing);
      expect(find.text('Chambray shirt'), findsOneWidget);
    });
  });
}
