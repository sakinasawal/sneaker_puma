import 'package:flutter/material.dart';
import 'package:sneaker_puma/models/shoe.dart';

class Cart extends ChangeNotifier {

  // list of shoes
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Puma satu', 
      price: '236', 
      imagePath: 'lib/images/puma_shoe.png', 
      description: 'The forward-thinking design of his latest signature shoe'
    ),

    Shoe(
      name: 'Puma 2', 
      price: '248', 
      imagePath: 'lib/images/puma_shoe_2.png', 
      description: 'yada yada yada yada yada yada kan bagus jogging'
    ),

    Shoe(
      name: 'Puma 3', 
      price: '567', 
      imagePath: 'lib/images/puma_shoe_3.png', 
      description: 'sesuai untuk shopping mall sebesar ioi putrajaya'
    ),

    Shoe(
      name: 'Puma 4', 
      price: '110', 
      imagePath: 'lib/images/puma_shoe_4.png', 
      description: 'Beli kasut yini sangat bagus, pakai lama tak sakit kaki'
    )
  ];

  // list of items in user cart
  List<Shoe> userCart = [];

  // get list of shoes for sale
  List<Shoe> getShoeList(){
    return shoeShop;
  }

  // get cart
  List<Shoe> getUserCart(){
    return userCart;
  }

  // add item to cart
  void addItemToCart(Shoe shoe){
    userCart.add(shoe);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Shoe shoe){
    userCart.remove(shoe);
    notifyListeners();
  }
}