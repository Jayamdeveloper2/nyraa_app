// lib/data/products_data.dart

// Product model class with multiple images and specification/about fields
class Product {
  final int id;
  final String image; // Primary image
  final List<String> images; // Multiple images
  final String name;
  final double originalPrice;
  final double price;
  final double rating;
  final int discount;
  final String description;
  final String size;
  final String style;
  final String material;
  final String brand;
  final String availability;
  final String color;
  final String category;
  final int reviewCount;
  final String sku;
  final String vendor;
  final String topic;
  final Map<String, String> specifications; // Specification details
  final String about; // About description

  Product({
    required this.id,
    required this.image,
    required this.images,
    required this.name,
    required this.originalPrice,
    required this.price,
    required this.rating,
    required this.discount,
    required this.description,
    required this.size,
    required this.style,
    required this.material,
    required this.brand,
    required this.availability,
    required this.color,
    required this.category,
    required this.reviewCount,
    required this.sku,
    required this.vendor,
    required this.topic,
    required this.specifications,
    required this.about,
  });
}

// CategoryImage model class
class CategoryImage {
  final int id;
  final String name;
  final String image;

  CategoryImage({
    required this.id,
    required this.name,
    required this.image,
  });
}

// TopDeal model class
class TopDeal {
  final int id;
  final String name;
  final String image;
  final String topic;

  TopDeal({
    required this.id,
    required this.name,
    required this.image,
    required this.topic,
  });
}

// FlashSale model class
class FlashSale {
  final int id;
  final String name;
  final String image;
  final int discount;

  FlashSale({
    required this.id,
    required this.name,
    required this.image,
    required this.discount,
  });
}

// Product data with multiple images, specifications, and about
final List<Product> allProducts = [
  Product(
    id: 1,
    image: "assets/images/productlist/product1.jpg",
    images: [
      "assets/images/productlist/product1.jpg",
      "assets/images/productlist/product2.jpg",
      "assets/images/productlist/product3.jpg",
      "assets/images/productlist/product4.jpg",
      "assets/images/productlist/product5.jpg",
    ],
    name: "Elegant Rose Gold Dress",
    originalPrice: 79.0,
    price: 72.0,
    rating: 4.0,
    discount: 9,
    description: "Elevate your style with this Elegant Rose Gold Dress, crafted from premium silk for comfort and durability. Its elegant design is perfect for formal or casual occasions. Easy to care for: dry clean only.",
    size: "M",
    style: "elegant",
    material: "Silk",
    brand: "ModaVibe",
    availability: "In Stock",
    color: "Rose Gold",
    category: "dresses",
    reviewCount: 120,
    sku: "ERGD-001",
    vendor: "ModaVibe Collections",
    topic: "Festive Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Rose Gold',
      'Fabric': 'Silk',
      'Type': 'One Piece',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Elevate your style with this Elegant Rose Gold Dress, crafted from premium silk for comfort and durability. Its elegant design is perfect for formal or casual occasions. Easy to care for: dry clean only.",
  ),
  Product(
    id: 2,
    image: "assets/images/productlist/product2.jpg",
    images: [
      "assets/images/productlist/product2.jpg",
      "assets/images/productlist/product3.jpg",
      "assets/images/productlist/product4.jpg",
      "assets/images/productlist/product5.jpg",
      "assets/images/productlist/product6.jpg",
    ],
    name: "Chic Summer Dress",
    originalPrice: 150.0,
    price: 140.0,
    rating: 5.0,
    discount: 7,
    description: "Elevate your style with this Chic Summer Dress, crafted from premium cotton for comfort and durability. Its modern design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
    size: "S",
    style: "modern",
    material: "Cotton",
    brand: "ChicNest",
    availability: "In Stock",
    color: "White",
    category: "dresses",
    sku: "CSD-002",
    vendor: "ChicNest Collections",
    reviewCount: 90,
    topic: "Party Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'White',
      'Fabric': 'Cotton',
      'Type': 'One Piece',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Elevate your style with this Chic Summer Dress, crafted from premium cotton for comfort and durability. Its modern design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
  ),
  Product(
    id: 3,
    image: "assets/images/productlist/product3.jpg",
    images: [
      "assets/images/productlist/product3.jpg",
      "assets/images/productlist/product4.jpg",
      "assets/images/productlist/product5.jpg",
      "assets/images/productlist/product6.jpg",
      "assets/images/productlist/product7.jpg",
    ],
    name: "Floral Maxi Dress",
    originalPrice: 95.0,
    price: 90.0,
    rating: 4.0,
    discount: 5,
    description: "Elevate your style with this Floral Maxi Dress, crafted from premium chiffon for comfort and durability. Its bohemian design is perfect for formal or casual occasions. Easy to care for: hand wash, lay flat to dry.",
    size: "M",
    style: "bohemian",
    material: "Chiffon",
    brand: "ModaVibe",
    availability: "In Stock",
    color: "Multicolor",
    category: "dresses",
    sku: "FMD-003",
    vendor: "ModaVibe Collections",
    reviewCount: 80,
    topic: "Fashion Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Multicolor',
      'Fabric': 'Chiffon',
      'Type': 'One Piece',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Elevate your style with this Floral Maxi Dress, crafted from premium chiffon for comfort and durability. Its bohemian design is perfect for formal or casual occasions. Easy to care for: hand wash, lay flat to dry.",
  ),
  Product(
    id: 4,
    image: "assets/images/productlist/product4.jpg",
    images: [
      "assets/images/productlist/product4.jpg",
      "assets/images/productlist/product5.jpg",
      "assets/images/productlist/product6.jpg",
      "assets/images/productlist/product7.jpg",
      "assets/images/productlist/product8.jpg",
    ],
    name: "Classic Yellow Top",
    originalPrice: 250.0,
    price: 250.0,
    rating: 4.0,
    discount: 0,
    description: "Elevate your style with this Classic Yellow Top, crafted from premium cotton for comfort and durability. Its classic design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
    size: "L",
    style: "classic",
    material: "Cotton",
    brand: "TrendMuse",
    availability: "In Stock",
    color: "Yellow",
    category: "tops",
    sku: "CYT-004",
    vendor: "TrendMuse Collections",
    reviewCount: 85,
    topic: "Casual Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Yellow',
      'Fabric': 'Cotton',
      'Type': 'One Piece',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Elevate your style with this Classic Yellow Top, crafted from premium cotton for comfort and durability. Its classic design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
  ),
  Product(
    id: 5,
    image: "assets/images/productlist/product5.jpg",
    images: [
      "assets/images/productlist/product5.jpg",
      "assets/images/productlist/product6.jpg",
      "assets/images/productlist/product7.jpg",
      "assets/images/productlist/product8.jpg",
      "assets/images/productlist/product9.jpg",
    ],
    name: "Casual Denim Shirt",
    originalPrice: 90.0,
    price: 85.0,
    rating: 4.0,
    discount: 6,
    description: "Elevate your style with this Casual Denim Shirt, crafted from premium denim for comfort and durability. Its casual design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
    size: "M",
    style: "casual",
    material: "Denim",
    brand: "GlamCove",
    availability: "In Stock",
    color: "Blue",
    category: "tops",
    sku: "CDS-005",
    vendor: "GlamCove Collections",
    reviewCount: 95,
    topic: "Casual Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Blue',
      'Fabric': 'Denim',
      'Type': 'One Piece',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Elevate your style with this Casual Denim Shirt, crafted from premium denim for comfort and durability. Its casual design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
  ),
  Product(
    id: 6,
    image: "assets/images/productlist/product6.jpg",
    images: [
      "assets/images/productlist/product6.jpg",
      "assets/images/productlist/product7.jpg",
      "assets/images/productlist/product8.jpg",
      "assets/images/productlist/product9.jpg",
      "assets/images/productlist/product10jpg",
    ],
    name: "Leather Jacket",
    originalPrice: 200.0,
    price: 180.0,
    rating: 4.5,
    discount: 10,
    description: "Stay stylish with this Leather Jacket, crafted from premium leather for durability and comfort. Perfect for cool weather or a night out. Easy to care for: professional leather cleaning.",
    size: "L",
    style: "modern",
    material: "Leather",
    brand: "TrendMuse",
    availability: "In Stock",
    color: "Black",
    category: "jackets",
    sku: "LJ-006",
    vendor: "TrendMuse Collections",
    reviewCount: 110,
    topic: "Winter Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Black',
      'Fabric': 'Leather',
      'Type': 'Jacket',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Stay stylish with this Leather Jacket, crafted from premium leather for durability and comfort. Perfect for cool weather or a night out. Easy to care for: professional leather cleaning.",
  ),
  Product(
    id: 7,
    image: "assets/images/productlist/product7.jpg",
    images: [
      "assets/images/productlist/product7.jpg",
      "assets/images/productlist/product8.jpg",
      "assets/images/productlist/product9.jpg",
      "assets/images/productlist/product10.jpg",
      "assets/images/productlist/product1.jpg",
    ],
    name: "High-Waist Jeans",
    originalPrice: 70.0,
    price: 65.0,
    rating: 4.2,
    discount: 7,
    description: "Upgrade your wardrobe with these High-Waist Jeans, crafted from premium denim for comfort and durability. Perfect for casual or semi-formal looks. Easy to care for: machine wash cold, tumble dry low.",
    size: "S",
    style: "casual",
    material: "Denim",
    brand: "GlamCove",
    availability: "In Stock",
    color: "Dark Blue",
    category: "pants",
    sku: "HWJ-007",
    vendor: "GlamCove Collections",
    reviewCount: 75,
    topic: "Casual Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Dark Blue',
      'Fabric': 'Denim',
      'Type': 'Jeans',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Upgrade your wardrobe with these High-Waist Jeans, crafted from premium denim for comfort and durability. Perfect for casual or semi-formal looks. Easy to care for: machine wash cold, tumble dry low.",
  ),
  Product(
    id: 8,
    image: "assets/images/productlist/product8.jpg",
    images: [
      "assets/images/productlist/product8.jpg",
      "assets/images/productlist/product9.jpg",
      "assets/images/productlist/product10.jpg",
      "assets/images/productlist/product1.jpg",
      "assets/images/productlist/product2.jpg",
    ],
    name: "Silk Scarf",
    originalPrice: 45.0,
    price: 40.0,
    rating: 4.8,
    discount: 11,
    description: "Add elegance with this Silk Scarf, crafted from premium silk for a luxurious feel. Perfect for accessorizing any outfit. Easy to care for: hand wash, lay flat to dry.",
    size: "One Size",
    style: "elegant",
    material: "Silk",
    brand: "ChicNest",
    availability: "In Stock",
    color: "Red",
    category: "accessories",
    sku: "SS-008",
    vendor: "ChicNest Collections",
    reviewCount: 60,
    topic: "Fashion Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Red',
      'Fabric': 'Silk',
      'Type': 'Scarf',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Add elegance with this Silk Scarf, crafted from premium silk for a luxurious feel. Perfect for accessorizing any outfit. Easy to care for: hand wash, lay flat to dry.",
  ),
  Product(
    id: 9,
    image: "assets/images/productlist/product9.jpg",
    images: [
      "assets/images/productlist/product9.jpg",
      "assets/images/productlist/product10.jpg",
      "assets/images/productlist/product1.jpg",
      "assets/images/productlist/product2.jpg",
      "assets/images/productlist/product3.jpg",
    ],
    name: "A-Line Skirt",
    originalPrice: 60.0,
    price: 55.0,
    rating: 4.3,
    discount: 8,
    description: "Look chic with this A-Line Skirt, crafted from premium cotton blend for comfort and durability. Perfect for casual or professional settings. Easy to care for: machine wash cold, tumble dry low.",
    size: "M",
    style: "classic",
    material: "Cotton Blend",
    brand: "ModaVibe",
    availability: "In Stock",
    color: "Navy",
    category: "skirts",
    sku: "ALS-009",
    vendor: "ModaVibe Collections",
    reviewCount: 70,
    topic: "Casual Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Navy',
      'Fabric': 'Cotton Blend',
      'Type': 'Skirt',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Look chic with this A-Line Skirt, crafted from premium cotton blend for comfort and durability. Perfect for casual or professional settings. Easy to care for: machine wash cold, tumble dry low.",
  ),
  Product(
    id: 10,
    image: "assets/images/productlist/product10.jpg",
    images: [
      "assets/images/productlist/product10.jpg",
      "assets/images/productlist/product1.jpg",
      "assets/images/productlist/product2.jpg",
      "assets/images/productlist/product3.jpg",
      "assets/images/productlist/product4.jpg",
    ],
    name: "Quilted Bomber Jacket",
    originalPrice: 120.0,
    price: 110.0,
    rating: 4.6,
    discount: 8,
    description: "Stay warm and stylish with this Quilted Bomber Jacket, crafted from premium polyester for comfort and durability. Perfect for casual outings or cool weather. Easy to care for: machine wash cold, tumble dry low.",
    size: "M",
    style: "casual",
    material: "Polyester",
    brand: "GlamCove",
    availability: "In Stock",
    color: "Green",
    category: "jackets",
    sku: "QBJ-010",
    vendor: "GlamCove Collections",
    reviewCount: 100,
    topic: "Winter Wear",
    specifications: {
      'Quantity': '1',
      'Color': 'Green',
      'Fabric': 'Polyester',
      'Type': 'Jacket',
      'Detail': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.',
    },
    about: "Stay warm and stylish with this Quilted Bomber Jacket, crafted from premium polyester for comfort and durability. Perfect for casual outings or cool weather. Easy to care for: machine wash cold, tumble dry low.",
  ),
];

// Category images list
final List<CategoryImage> categoryImages = [
  CategoryImage(id: 1, name: "Dresses", image: "assets/images/category/category1.jpg"),
  CategoryImage(id: 2, name: "Tops", image: "assets/images/category/category4.jpg"),
  CategoryImage(id: 3, name: "Pants", image: "assets/images/category/category5.jpg"),
  CategoryImage(id: 4, name: "Jackets", image: "assets/images/category/category3.jpg"),
  CategoryImage(id: 5, name: "Skirts", image: "assets/images/category/category6.jpg"),
  CategoryImage(id: 6, name: "Accessories", image: "assets/images/category/category2.jpg"),
];

// Top deals list
final List<TopDeal> topDeals = [
  TopDeal(id: 1, name: "Leather Jacket", image: "assets/images/topdeals/product1.jpg", topic: "Winter Wear"),
  TopDeal(id: 2, name: "Elegant Rose Gold Dress", image: "assets/images/topdeals/product2.jpg", topic: "Festive Wear"),
  TopDeal(id: 3, name: "Floral Maxi Dress", image: "assets/images/topdeals/product3.jpg", topic: "Fashion Wear"),
  TopDeal(id: 4, name: "Denim Jacket", image: "assets/images/topdeals/product4.jpg", topic: "Western Wear"),
  TopDeal(id: 5, name: "Casual Denim Shirt", image: "assets/images/topdeals/product5.jpg", topic: "Casual Wear"),
  TopDeal(id: 6, name: "Chic Summer Dress", image: "assets/images/topdeals/product6.jpg", topic: "Party Wear"),
];

// Flash sale list
final List<FlashSale> flashSales = [
  FlashSale(id: 1, name: "Elegant Rose Gold Dress", image: "assets/images/flashsale/product1.jpg", discount: 9),
  FlashSale(id: 2, name: "Chic Summer Dress", image: "assets/images/flashsale/product2.jpg", discount: 7),
  FlashSale(id: 3, name: "Floral Maxi Dress", image: "assets/images/flashsale/product3.jpg", discount: 5),
  FlashSale(id: 4, name: "Quilted Bomber Jacket", image: "assets/images/flashsale/product4.jpg", discount: 6),
  FlashSale(id: 5, name: "Quilted Bomber Jacket", image: "assets/images/flashsale/product5.jpg", discount: 5),
  FlashSale(id: 6, name: "Quilted Bomber Jacket", image: "assets/images/flashsale/product6.jpg", discount: 4),
];

// Banner images list
final List<String> bannerImages = [
  "assets/images/banner/banner1.jpg",
  "assets/images/banner/banner2.jpg",
];

// Normal banner images list
final List<String> normalBannerImages = [
  "assets/images/normalbanner/banner1.jpg",
];