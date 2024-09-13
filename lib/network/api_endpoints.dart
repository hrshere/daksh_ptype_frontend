
class ApiEndpoints {
  static const baseUrl = "https://hrshere.pythonanywhere.com/api/"; //prod
  // static const baseUrl = "http://127.0.0.1:8000//api"; //dev

  //login api
  static const login = "/token/";

  static const category = "/categories/";
  static const shape = "/shapes/";
  static const material = "/materials/";
  static const products = "/products/";
  static const productsById = "/products/";
  static const orders = "/orders/";
  static const createPaymentIntent = '/create-payment-intent/';

}
