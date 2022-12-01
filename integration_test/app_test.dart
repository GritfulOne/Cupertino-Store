import 'package:cupertino_store/app.dart';
import 'package:cupertino_store/model/app_state_model.dart';
import 'package:cupertino_store/model/products_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

Widget createApp() => ChangeNotifierProvider<AppStateModel>(
      create: (context) =>
          AppStateModel(productRepository: DefaultProductsRepository())
            ..loadProducts(),
      child: const CupertinoApp(
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: CupertinoStoreApp(),
      ),
    );

void main() {
  group('Testing App Performance Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(createApp());

      final listFinder = find.byType(CustomScrollView);

      await binding.watchPerformance(() async {
        await tester.fling(listFinder, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(listFinder, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');
    });

    testWidgets('Add to cart operations test', (tester) async {
      await tester.pumpWidget(createApp());

      final productNames = [
        'Vagabond sack',
        'Stella sunglasses',
        'Whitney belt',
      ];

      for (var name in productNames) {
        var row =
            find.ancestor(of: find.text(name), matching: find.byType(Row));

        await tester.tap(
            find.descendant(of: row, matching: find.byType(CupertinoButton)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      await tester.tap(find.text('Cart'));
      await tester.pumpAndSettle();

      expect(find.text('Vagabond sack'), findsOneWidget);
      expect(find.text('Stella sunglasses'), findsOneWidget);
      expect(find.text('Whitney belt'), findsOneWidget);
    });
  });
}
