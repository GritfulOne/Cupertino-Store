import 'package:test/test.dart';
import 'package:cupertino_store/model/product.dart';


void main() {
  group('Testing Product', () {
    const mockProduct = Product(
      category: Category.accessories,
      id: 0,
      isFeatured: true,
      name: 'Vagabond sack',
      price: 120,
    );

    test('Product property getters\' returns should be in specific formats', () {
      expect(mockProduct.assetName, '0-0.jpg');
      expect(mockProduct.assetPackage, 'shrine_images');
      expect(mockProduct.toString(), 'Vagabond sack (id=0)');
    });

  });
}