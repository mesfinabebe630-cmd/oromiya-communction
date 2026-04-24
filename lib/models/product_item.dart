class ProductItem {
  final String name;
  final String price;
  final String imageUrl;
  final String description;

  ProductItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.description = '',
  });
}
