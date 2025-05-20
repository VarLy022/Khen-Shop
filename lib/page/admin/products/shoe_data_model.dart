
// Data model for a shoe
class Shoe {
  int? shoeId;
  String name;
  String brand;
  double price;
  int stock;
  String size;
  String color;
  String description;
  String imageUrl;

  Shoe({
    this.shoeId,
    required this.name,
    required this.brand,
    required this.price,
    required this.stock,
    required this.size,
    required this.color,
    required this.description,
    required this.imageUrl,
  });

  // Factory method to create a Shoe object from JSON data
  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      shoeId: json['shoe_id'],
      name: json['name'],
      brand: json['brand'],
      price: double.parse(json['price'].toString()), // Ensure price is a double
      stock: json['stock'],
      size: json['size'],
      color: json['color'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  // Method to convert a Shoe object to JSON for sending to the server
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'stock': stock,
      'size': size,
      'color': color,
      'description': description,
      'image_url': imageUrl,
    };
  }
}