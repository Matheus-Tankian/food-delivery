import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fooddeliveryui/data/data.dart';
import 'package:flutter_fooddeliveryui/models/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  _buildCartItem(Order order){
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 170.0,
      child: Row(
        children: [
         Expanded(
           child: Row(
             children: [
               Container(
                 width: 150.0,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage(order.food.imageUrl),
                     fit: BoxFit.cover,
                   ),
                   borderRadius: BorderRadius.circular(15.0),
                 ),
               ),
               Expanded(
                 child: Container(
                   margin: EdgeInsets.all(12.0),
                   child:   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         order.food.name,
                         style: TextStyle(
                           fontSize: 20.0,
                           fontWeight: FontWeight.bold,
                         ),
                         overflow: TextOverflow.ellipsis,
                       ),
                       SizedBox(height: 10.0),
                       Text(
                         order.restaurant.name,
                         style: TextStyle(
                           fontSize: 16.0,
                           fontWeight: FontWeight.w600,
                         ),
                         overflow: TextOverflow.ellipsis,
                       ),
                       SizedBox(height: 10.0),

                       Container(
                         width: 100.0,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           border: Border.all(
                             width: 0.8,
                             color: Colors.black54,
                           )
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                            GestureDetector(
                              onTap: () {},
                              child:  Text(
                                '-',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                             SizedBox(width: 20.0),

                             Text(
                               order.quantity.toString(),
                               style: TextStyle(
                                 fontSize: 20.0,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),

                             SizedBox(width: 20.0),

                             GestureDetector(
                               onTap: () {},
                               child:Text(
                                 '+',
                                 style: TextStyle(
                                   color: Theme.of(context).primaryColor,
                                   fontSize: 20.0,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),

                     ],
                   ),
                 ),
               ),
             ],
           ),
         ),
         Container(
           margin: EdgeInsets.all(10.0),
           child:  Text(
             '\$${order.quantity * order.food.price}',
             style: TextStyle(
               fontWeight: FontWeight.w600,
               fontSize: 16.0,
             ),
           ),
         ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double totalPrice = 0;
    currentUser.cart.forEach(
        (Order order)=> totalPrice += order.quantity * order.food.price,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${currentUser.cart.length})'),
      ),

      body:ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext, int index){
          if(index< currentUser.cart.length){
            Order order = currentUser.cart[index];
            return _buildCartItem(order);
          }

          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimate Delivery Time:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '25 min',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Cost:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80.0),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext, int index){
          return Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
      ),
      bottomSheet: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: FlatButton(
            child: Text(
              'CHECKOUT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
