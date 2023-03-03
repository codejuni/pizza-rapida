import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_rapida/models/cart_model.dart';
import 'package:pizza_rapida/models/pizza_model.dart';
import 'package:pizza_rapida/pages/home_controller.dart';
import 'package:pizza_rapida/tiles/pizza_tile.dart';

class HomePage extends GetWidget<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      endDrawer: Obx(() => Drawer(
            width: 150,
            backgroundColor: Colors.grey[300],
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 20,
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 18,
                  icon: CircleAvatar(
                    backgroundColor: Colors.grey[350],
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Your\nOrder',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.cart.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30),
                    itemBuilder: (context, index) {
                      CartModel cart = controller.cart[index];
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                cart.pizza.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -47),
                            child: IconButton(
                              onPressed: () => controller.deleteCart(index),
                              splashRadius: 18,
                              icon: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black26,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '\$${controller.totalPrice.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 18,
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.check,
                      color: Colors.grey[350],
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
      body: Obx(
        () => controller.isLoading.value
            ? Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, -size.height * 0.45),
                    child: Transform.scale(
                      scale: 1.4,
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[350],
                        ),
                        child: Transform.translate(
                          offset: Offset(0, size.width * 0.45),
                          child: PageView.builder(
                            itemCount: PizzaModel.pizzas.length,
                            controller: controller.pageController,
                            itemBuilder: (context, index) {
                              PizzaModel model = PizzaModel.pizzas[index];

                              return PizzaTile(
                                controller: controller,
                                model: model,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kToolbarHeight + MediaQuery.of(context).padding.top,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () =>
                            globalKey.currentState!.openEndDrawer(),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: size.height * 0.48,
                    height: size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                child: IconButton(
                                  onPressed: controller.back,
                                  splashRadius: 20,
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.grey[350],
                                    radius: 20,
                                    child: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: AnimatedSwitcher(
                                    duration: controller.duration,
                                    child: Text(
                                      PizzaModel
                                          .pizzas[
                                              controller.currentPage.toInt()]
                                          .name,
                                      textAlign: TextAlign.center,
                                      key: UniqueKey(),
                                      maxLines: 4,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: IconButton(
                                  onPressed: controller.next,
                                  splashRadius: 20,
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.grey[350],
                                    radius: 20,
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '12 reviews',
                                style: Get.theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            controller.pizzas[controller.currentPage.toInt()]
                                .description,
                            style: Get.theme.textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Text(
                                '\$${controller.pizzas[controller.currentPage.toInt()].price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '450 cal',
                                  style: Get.theme.textTheme.bodyMedium!,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '3 sugars',
                                  style: Get.theme.textTheme.bodyMedium!,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '250 mac',
                                  style: Get.theme.textTheme.bodyMedium!,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: controller.add,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Add to cart',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: controller.sum,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      controller.count.toString(),
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: controller.remove,
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
