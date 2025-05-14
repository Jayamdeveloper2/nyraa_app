// Product model class with only a single image and topic
class Product {
  final int id;
  final String image; // Only one image field
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
  final String topic; // Field for topic

  Product({
    required this.id,
    required this.image,
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
  });
}

// CategoryImage model class
class CategoryImage {
  final int id;
  final String name; // Category name (e.g., Dresses)
  final String image; // Image URL or path

  CategoryImage({
    required this.id,
    required this.name,
    required this.image,
  });
}

// TopDeal model class
class TopDeal {
  final int id;
  final String name; // Product name
  final String image; // Image URL or path
  final String topic; // Topic (e.g., Winter Wear)

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
  final String name; // Product name
  final String image; // Image URL or path
  final int discount; // Discount percentage

  FlashSale({
    required this.id,
    required this.name,
    required this.image,
    required this.discount,
  });
}

// Product data with single image per product and topic
final List<Product> allProducts = [
  Product(
    id: 1,
    image: "assets/images/productlist/product1.jpg",
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
  ),
  Product(
    id: 2,
    image: "./assets/images/productlist/product2.jpg",
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
  ),
  Product(
    id: 3,
    image: "assets/images/productlist/product3.jpg",
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
  ),
  Product(
    id: 4,
    image: "assets/images/productlist/product4.jpg",
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
  ),
  Product(
    id: 5,
    image: "assets/images/productlist/product5.jpg",
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
  ),
  Product(
    id: 6,
    image: "assets/images/productlist/product6.jpg",
    name: "Sleeveless Crop Top",
    originalPrice: 60.0,
    price: 55.0,
    rating: 3.0,
    discount: 8,
    description: "Elevate your style with this Sleeveless Crop Top, crafted from premium cotton for comfort and durability. Its modern design is perfect for everyday or professional settings. Easy to care for: machine wash cold, tumble dry low.",
    size: "S",
    style: "modern",
    material: "Cotton",
    brand: "EvoCouture",
    availability: "In Stock",
    color: "Red",
    category: "tops",
    sku: "SCT-006",
    vendor: "EvoCouture Collections",
    reviewCount: 75,
    topic: "Fashion Wear",
  ),
  Product(
    id: 7,
    image: "assets/images/productlist/product7.jpg",
    name: "Linen Trousers",
    originalPrice: 110.0,
    price: 105.0,
    rating: 4.0,
    discount: 5,
    description: "Elevate your style with this Linen Trousers, crafted from premium linen for comfort and durability. Its casual design is perfect for work or leisure. Easy to care for: hand wash, lay flat to dry.",
    size: "L",
    style: "casual",
    material: "Linen",
    brand: "CoutureBloom",
    availability: "In Stock",
    color: "Beige",
    category: "pants",
    sku: "LT-007",
    vendor: "CoutureBloom Collections",
    reviewCount: 65,
    topic: "Casual Wear",
  ),
  Product(
    id: 8,
    image: "assets/images/productlist/product8.jpg",
    name: "Tailored Trousers",
    originalPrice: 130.0,
    price: 125.0,
    rating: 4.0,
    discount: 4,
    description: "Elevate your style with this Tailored Trousers, crafted from premium wool for comfort and durability. Its formal design is perfect for work or leisure. Easy to care for: dry clean only.",
    size: "M",
    style: "formal",
    material: "Wool",
    brand: "ModaVibe",
    availability: "In Stock",
    color: "Grey",
    category: "pants",
    sku: "TT-008",
    vendor: "ModaVibe Collections",
    reviewCount: 70,
    topic: "Western Wear",
  ),
  Product(
    id: 9,
    image: "assets/images/productlist/product9.jpg",
    name: "High-Waisted Jeans",
    originalPrice: 100.0,
    price: 95.0,
    rating: 4.0,
    discount: 5,
    description: "Elevate your style with this High-Waisted Jeans, crafted from premium denim for comfort and durability. Its casual design is perfect for work or leisure. Easy to care for: machine wash cold, tumble dry low.",
    size: "S",
    style: "casual",
    material: "Denim",
    brand: "LuxeMint",
    availability: "In Stock",
    color: "Blue",
    category: "pants",
    sku: "HWJ-009",
    vendor: "LuxeMint Collections",
    reviewCount: 80,
    topic: "Western Wear",
  ),
  Product(
    id: 10,
    image: "assets/images/productlist/product10.jpg",
    name: "Leather Jacket",
    originalPrice: 220.0,
    price: 200.0,
    rating: 5.0,
    discount: 9,
    description: "Elevate your style with this Leather Jacket, crafted from premium leather for comfort and durability. Its modern design is perfect for cooler days or bold looks. Easy to care for: wipe clean with a damp cloth.",
    size: "L",
    style: "modern",
    material: "Leather",
    brand: "ModaVibe",
    availability: "In Stock",
    color: "Black",
    category: "jackets",
    sku: "LJ-010",
    vendor: "ModaVibe Collections",
    reviewCount: 70,
    topic: "Winter Wear",
  ),
  Product(
    id: 11,
    image: "assets/images/productlist/product5.jpg",
    name: "Denim Jacket",
    originalPrice: 150.0,
    price: 140.0,
    rating: 4.0,
    discount: 7,
    description: "Elevate your style with this Denim Jacket, crafted from premium denim for comfort and durability. Its casual design is perfect for cooler days or bold looks. Easy to care for: machine wash cold, tumble dry low.",
    size: "S",
    style: "casual",
    material: "Denim",
    brand: "Fashnory",
    availability: "In Stock",
    color: "Blue",
    category: "jackets",
    sku: "DJ-011",
    vendor: "Fashnory Collections",
    reviewCount: 75,
    topic: "Western Wear",
  ),
  Product(
    id: 12,
    image: "assets/images/productlist/product6.jpg",
    name: "Quilted Bomber Jacket",
    originalPrice: 180.0,
    price: 170.0,
    rating: 4.0,
    discount: 6,
    description: "Elevate your style with this Quilted Bomber Jacket, crafted from premium polyester for comfort and durability. Its casual design is perfect for cooler days or bold looks. Easy to care for: machine wash cold, tumble dry low.",
    size: "M",
    style: "casual",
    material: "Polyester",
    brand: "ModaVibe",
    availability: "In Stock",
    color: "Green",
    category: "jackets",
    sku: "QBJ-012",
    vendor: "ModaVibe Collections",
    reviewCount: 60,
    topic: "Winter Wear",
  ),
];

// Category images list with objects
final List<CategoryImage> categoryImages = [
  CategoryImage(
    id: 1,
    name: "Dresses",
    image: "assets/images/category/category1.jpg",
  ),
  CategoryImage(
    id: 2,
    name: "Tops",
    image: "assets/images/category/category4.jpg",
  ),
  CategoryImage(
    id: 3,
    name: "Pants",
    image: "assets/images/category/category5.jpg",
  ),
  CategoryImage(
    id: 4,
    name: "Jackets",
    image: "assets/images/category/category3.jpg",
  ),
  CategoryImage(
    id: 5,
    name: "Skirts",
    image: "assets/images/category/category6.jpg",
  ),
  CategoryImage(
    id: 6,
    name: "Accessories",
    image: "assets/images/category/category2.jpg",
  ),
];

// Top deals list with objects
final List<TopDeal> topDeals = [
  TopDeal(
    id: 1,
    name: "Leather Jacket",
    image: "assets/images/topdeals/product1.jpg",
    topic: "Winter Wear",
  ),
  TopDeal(
    id: 2,
    name: "Elegant Rose Gold Dress",
    image: "assets/images/topdeals/product2.jpg",
    topic: "Festive Wear",
  ),
  TopDeal(
    id: 3,
    name: "Floral Maxi Dress",
    image: "assets/images/topdeals/product3.jpg",
    topic: "Fashion Wear",
  ),
  TopDeal(
    id: 4,
    name: "Denim Jacket",
    image: "assets/images/topdeals/product4.jpg",
    topic: "Western Wear",
  ),
  TopDeal(
    id: 5,
    name: "Casual Denim Shirt",
    image: "assets/images/topdeals/product5.jpg",
    topic: "Casual Wear",
  ),
  TopDeal(
    id: 6,
    name: "Chic Summer Dress",
    image: "assets/images/topdeals/product6.jpg",
    topic: "Party Wear",
  ),
];

// Flash sale list with objects
final List<FlashSale> flashSales = [
  FlashSale(
    id: 1,
    name: "Elegant Rose Gold Dress",
      image: "assets/images/flashsale/product1.jpg",
    discount: 9,
  ),
  FlashSale(
    id: 2,
    name: "Chic Summer Dress",
    image: "assets/images/flashsale/product2.jpg",
    discount: 7,
  ),
  FlashSale(
    id: 3,
    name: "Floral Maxi Dress",
    image: "assets/images/flashsale/product3.jpg",
    discount: 5,
  ),
  FlashSale(
    id: 4,
    name: "Quilted Bomber Jacket",
    image: "assets/images/flashsale/product4.jpg",
    discount: 6,
  ),
  FlashSale(
    id: 5,
    name: "Quilted Bomber Jacket",
    image: "assets/images/flashsale/product5.jpg",
    discount: 5,
  ),
  FlashSale(
    id: 5,
    name: "Quilted Bomber Jacket",
    image: "assets/images/flashsale/product6.jpg",
    discount: 4,
  ),


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