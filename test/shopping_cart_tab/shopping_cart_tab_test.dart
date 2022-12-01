import 'package:cupertino_store/model/products_repository.dart';
import 'package:cupertino_store/shopping_cart_tab/shopping_cart_tab.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_store/model/app_state_model.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createShoppingCartTab() {
  var appStateModel =
      AppStateModel(productRepository: DefaultProductsRepository())
        ..loadProducts()
        ..addProductToCart(15)
        ..addProductToCart(16)
        ..addProductToCart(17)
        ..addProductToCart(18)
        ..addProductToCart(19);

  return ChangeNotifierProvider<AppStateModel>(
    create: (context) => appStateModel,
    child: const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ShoppingCartTab(),
    ),
  );
}

void main() {
  group('Shopping Cart Tab Widget Tests', () {
    testWidgets('Testing Initial Load', (tester) async {
      await tester.pumpWidget(createShoppingCartTab());
      expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.person_solid), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.mail_solid), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.location_solid), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.person_solid), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('Delivery time'), findsOneWidget);
      expect(find.text('Chambray napkins'), findsOneWidget);
    });

    testWidgets('Testing entering texts to textfields', (tester) async {
      await tester.pumpWidget(createShoppingCartTab());

      await tester.enterText(
        find.ancestor(
          of: find.text('Name'), matching: find.byType(CupertinoTextField)),
         'hi');
      await tester.enterText(
        find.ancestor(
          of: find.text('Email'), matching: find.byType(CupertinoTextField)),
         'test@email.com');
      await tester.pump();
      expect(find.text('hi'), findsOneWidget);
      expect(find.text('Name'), findsNothing);

      expect(find.text('test@email.com'), findsOneWidget);
      expect(find.text('Email'), findsNothing);
    });
  });

}
