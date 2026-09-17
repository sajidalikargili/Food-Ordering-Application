class ProductModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final String categoryId;
  final double rating;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.rating,
  });

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] is num
          ? (data['price'] as num).toDouble()
          : double.tryParse(data['price'].toString()) ?? 0.0,
      categoryId: data['categoryId'] ?? '',
      image: data['image'] ?? '',
      rating: data['rating'] is num
          ? (data['rating'] as num).toDouble()
          : double.tryParse(data['rating'].toString()) ?? 0.0,
    );
  }
}
