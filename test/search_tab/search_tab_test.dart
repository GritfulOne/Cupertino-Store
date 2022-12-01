import 'package:cupertino_store/model/app_state_model.dart';
import 'package:cupertino_store/model/products_repository.dart';
import 'package:cupertino_store/product_list_tab/product_row_item.dart';
import 'package:cupertino_store/search_tab/search_bar.dart';
import 'package:cupertino_store/search_tab/search_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget createSearchTab() {
  return ChangeNotifierProvider<AppStateModel>(
    create: (context) => AppStateModel(productRepository: DefaultProductsRepository())..loadProducts(),
    child: const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: SearchTab(),
    ),
  );
}

void main() {
  
  testWidgets('Testing Initial Load', (tester) async {
      await tester.pumpWidget(createSearchTab());
      expect(find.byType(ProductRowItem), findsAtLeastNWidgets(1));
      expect(find.byIcon(CupertinoIcons.search), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.clear), findsOneWidget);

      expect(find.text('Vagabond sack'), findsOneWidget);
      expect(find.text('Stella sunglasses'), findsOneWidget);
      expect(find.text('Whitney belt'), findsOneWidget);
    });

    testWidgets('Testing entering texts to searchfield', (tester) async {
      await tester.pumpWidget(createSearchTab());

      await tester.enterText(
        find.byType(SearchBar), 
        'Vagabond'
      );
      await tester.pump();

      expect(find.text('Vagabond sack'), findsOneWidget);
      expect(find.text('Stella sunglasses'), findsNothing);
      expect(find.text('Whitney belt'), findsNothing);

      await tester.tap(
        find.ancestor(
          of: find.byIcon(CupertinoIcons.clear),
          matching: find.byType(GestureDetector)));


      await tester.pump();

      expect(find.text('Vagabond sack'), findsOneWidget);
      expect(find.text('Stella sunglasses'), findsOneWidget);
      expect(find.text('Whitney belt'), findsOneWidget);
    });

}
