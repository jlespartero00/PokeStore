import '../models/product.dart';

final List<Product> mockProducts = [
  Product(
    id: 'p1',
    name: 'Pokeball',
    category: 'Pokeball',
    price: 10.0,
    description: 'A standard Pokeball for catching Pokémon.',
    image: 'assets/images/pokeball.png',
  ),
  Product(
    id: 'p2',
    name: 'Greatball',
    category: 'Pokeball',
    price: 20.0,
    description: 'A Greatball increases your chance of capture.',
    image: 'assets/images/greatball.png',
  ),
  Product(
    id: 'p3',
    name: 'Potion',
    category: 'Potion',
    price: 15.0,
    description: 'Restores 20 HP to a Pokémon.',
    image: 'assets/images/potion.png',
  ),
  Product(
    id: 'p4',
    name: 'Super Potion',
    category: 'Potion',
    price: 30.0,
    description: 'Restores 50 HP to a Pokémon.',
    image: 'assets/images/superpotion.png',
  ),
];
