import 'package:cupertino_store/model/product.dart' as product; 
import 'package:cupertino_store/model/products_repository.dart';
import 'package:test/test.dart';
import 'package:cupertino_store/model/app_state_model.dart';

void main() {
  group('Testing AppStateModel', () {
    var mockProductsRepo = DefaultProductsRepository();
    var appStateModel = AppStateModel(productRepository: mockProductsRepo);

    test('Products from the repository should be loaded', () {
      appStateModel.loadProducts();
      expect(appStateModel.getProducts().length, 38);
    });

    test('Set Category should be changed', () {
      expect(appStateModel.selectedCategory, product.Category.all);
      
      appStateModel.setCategory(product.Category.clothing);

      expect(appStateModel.selectedCategory, product.Category.clothing);
      expect(appStateModel.getProducts().length, 19);
    }); 

    test('Search should return only items with names that contains the search term and '
      'being within the selected category', () {
      expect(appStateModel.selectedCategory, product.Category.clothing);
      expect(appStateModel.search('tea').length, 0);

      appStateModel.setCategory(product.Category.all);
      expect(appStateModel.search('tea').length, 1);

      appStateModel.setCategory(product.Category.accessories);
      expect(appStateModel.search('tea').length, 0);

      appStateModel.setCategory(product.Category.home);
      expect(appStateModel.search('tea').length, 1);
    });

    test('Should return product with the given id', () {
      var product = appStateModel.getProductById(14);

      expect(product.name, 'Rainwater tray');
    });
  });


  group('Testing cart', () {
    var mockProductsRepo = DefaultProductsRepository();
    var appStateModel = AppStateModel(productRepository: mockProductsRepo)..loadProducts();

    test('Should return product with the given id', () {
      var productsInCart = appStateModel.productsInCart;
      
      expect(productsInCart.length, 0);
      expect(productsInCart[15], null);
      expect(appStateModel.totalCartQuantity, 0);
      expect(appStateModel.subtotalCost, 0);
      expect(appStateModel.shippingCost, 0);
      expect(appStateModel.tax, 0);
      expect(appStateModel.totalCost, 0);

      
      appStateModel.addProductToCart(15);

      productsInCart = appStateModel.productsInCart;

      expect(productsInCart.length, 1);
      expect(productsInCart[15], 1);
      expect(appStateModel.totalCartQuantity, 1);
      expect(appStateModel.subtotalCost, 16);
      expect(appStateModel.shippingCost, 7);
      expect(appStateModel.tax, 0.96);
      expect(appStateModel.totalCost, 23.96);


      appStateModel.addProductToCart(15);

      productsInCart = appStateModel.productsInCart;

      expect(productsInCart.length, 1);
      expect(productsInCart[15], 2);
      expect(appStateModel.totalCartQuantity, 2);
      expect(appStateModel.subtotalCost, 32);
      expect(appStateModel.shippingCost, 14);
      expect(appStateModel.tax, 1.92);
      expect(appStateModel.totalCost, 47.92);


      appStateModel.addProductToCart(16);

      productsInCart = appStateModel.productsInCart;

      expect(productsInCart.length, 2);
      expect(productsInCart[15], 2);
      expect(productsInCart[16], 1);
      expect(appStateModel.totalCartQuantity, 3);
      expect(appStateModel.subtotalCost, 48);
      expect(appStateModel.shippingCost, 21);
      expect(appStateModel.tax, 2.88);
      expect(appStateModel.totalCost, 71.88);


      appStateModel.removeItemFromCart(16);

      productsInCart = appStateModel.productsInCart;

      expect(productsInCart.length, 1);
      expect(productsInCart[15], 2);
      expect(productsInCart[16], null);
      expect(appStateModel.totalCartQuantity, 2);
      expect(appStateModel.subtotalCost, 32);
      expect(appStateModel.shippingCost, 14);
      expect(appStateModel.tax, 1.92);
      expect(appStateModel.totalCost, 47.92);


      appStateModel.removeItemFromCart(15);

      productsInCart = appStateModel.productsInCart;

      expect(productsInCart.length, 1);
      expect(productsInCart[15], 1);
      expect(productsInCart[16], null);
      expect(appStateModel.totalCartQuantity, 1);
      expect(appStateModel.subtotalCost, 16);
      expect(appStateModel.shippingCost, 7);
      expect(appStateModel.tax, 0.96);
      expect(appStateModel.totalCost, 23.96);


      appStateModel.clearCart();

      productsInCart = appStateModel.productsInCart;

      expect(productsInCart.length, 0);
      expect(productsInCart[15], null);
      expect(productsInCart[16], null);
      expect(appStateModel.totalCartQuantity, 0);
      expect(appStateModel.subtotalCost, 0);
      expect(appStateModel.shippingCost, 0);
      expect(appStateModel.tax, 0);
      expect(appStateModel.totalCost, 0);
    });

  });
}