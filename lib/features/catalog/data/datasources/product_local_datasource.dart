import '../../domain/entities/product.dart';
import '../../domain/entities/product_color.dart';

class ProductLocalDatasource {
  const ProductLocalDatasource();

  Future<List<Product>> getProducts() async {
    return const [
      Product(
        id: 'amazing-t-shirt',
        name: 'Amazing T-shirt',
        priceInCents: 1200,
        currencyCode: 'EUR',
        isAvailable: true,
        description:
            'A versatile everyday t-shirt made for comfortable, effortless style.',
        imageAssets: ['amazing-t-shirt-front', 'amazing-t-shirt-detail'],
        availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
        availableColors: [
          ProductColor(id: 'blue', name: 'Blue', colorValue: 0xFF087BFF),
          ProductColor(id: 'white', name: 'White', colorValue: 0xFFF7F9FC),
          ProductColor(id: 'black', name: 'Black', colorValue: 0xFF20242A),
        ],
      ),
      Product(
        id: 'fabulous-pants',
        name: 'Fabulous Pants',
        priceInCents: 1500,
        currencyCode: 'EUR',
        isAvailable: true,
      ),
      Product(
        id: 'light-summer-shirt',
        name: 'Light Summer Shirt',
        priceInCents: 1800,
        currencyCode: 'EUR',
        isAvailable: true,
      ),
      Product(
        id: 'everyday-sneakers',
        name: 'Everyday Sneakers',
        priceInCents: 2400,
        currencyCode: 'EUR',
        isAvailable: true,
      ),
    ];
  }
}
