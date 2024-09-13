import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();
  final String _cartKey = 'cart';

  // Add product ID to the cart
  Future<void> addProductToCart(int productId) async {
    List<int> cart = _storage.read<List<int>>(_cartKey) ?? [];
    if (!cart.contains(productId)) {
      cart.add(productId);
      await _storage.write(_cartKey, cart);
    }
  }

  // Remove product ID from the cart
  Future<void> removeProductFromCart(int productId) async {
    List<int> cart = _storage.read<List<int>>(_cartKey) ?? [];
    cart.remove(productId);
    await _storage.write(_cartKey, cart);
  }

  // Get list of product IDs in the cart
  List<int>? getCart() {
    return _storage.read<List<int>>(_cartKey);
  }

  // Clear the cart
  Future<void> clearCart() async {
    await _storage.remove(_cartKey);
  }
}
