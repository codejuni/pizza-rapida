class PizzaModel {
  String name;
  String image;
  double price;
  String description;

  PizzaModel({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  static List<PizzaModel> pizzas = [
    PizzaModel(
      name: 'Hawaiana',
      description:
          'Hawaiian pizza is another popular pizza in the United States. It is made with tomato sauce, mozzarella cheese, ham and pineapple. The combination of sweet and savory flavors makes this pizza very appetizing.',
      image: 'assets/1.png',
      price: 29.9,
    ),
    PizzaModel(
      name: 'Pepperoni',
      description:
          ' Pepperoni pizza is one of the most popular pizzas in the United States. It is made with tomato sauce, mozzarella cheese and pepperoni slices, a type of spicy salami. It is a tasty and spicy pizza.',
      image: 'assets/2.png',
      price: 27.6,
    ),
    PizzaModel(
      name: 'Margherita',
      description:
          'The Margherita pizza is a pizza originating in Naples, Italy, and is one of the most popular and well-known worldwide. It is made with fresh tomato sauce, buffalo mozzarella and fresh basil leaves. It´s a simple but delicious pizza',
      image: 'assets/3.png',
      price: 31.9,
    ),
  ];
}
