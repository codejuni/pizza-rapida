import 'package:flutter/material.dart';
import 'package:pizza_rapida/models/cart_model.dart';
import 'package:pizza_rapida/models/pizza_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<PizzaModel> pizzas = <PizzaModel>[].obs;
  PageController pageController = PageController(viewportFraction: 0.5);
  RxDouble currentPage = 0.0.obs;
  RxBool isLoading = false.obs;
  Duration duration = const Duration(milliseconds: 300);
  RxInt count = 1.obs;
  RxList<CartModel> cart = <CartModel>[].obs;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(_listener);
    getData();
  }

  getData() {
    pizzas.value = PizzaModel.pizzas;
    isLoading.value = true;
  }

  @override
  void dispose() {
    super.dispose();
    pageController.removeListener(_listener);
    pageController.dispose();
  }

  void _listener() {
    currentPage.value = pageController.page ?? 0;
  }

  void next() {
    if (currentPage.value == (PizzaModel.pizzas.length - 1)) return;
    animateToPage((currentPage.value + 1).toInt());
  }

  void back() {
    if (currentPage.value == 0) return;
    animateToPage((currentPage.value - 1).toInt());
  }

  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void sum() {
    if (count.value == 12) return;
    count.value++;
  }

  void remove() {
    if (count.value == 1) return;
    count.value--;
  }

  void add() {
    cart.add(
      CartModel(
        pizza: pizzas[currentPage.value.toInt()],
        count: count.value,
      ),
    );
    refresPrice();
  }

  void deleteCart(int index) {
    cart.removeAt(index);
    refresPrice();
  }

  void refresPrice() {
    totalPrice.value = cart.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.count * element.pizza.price));
  }
}
