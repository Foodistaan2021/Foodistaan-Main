import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/functions/cart_functions.dart';

class ChangeQuantityWidget extends StatefulWidget {
  var data, cartId;
  ChangeQuantityWidget({required this.data, required this.cartId});

  @override
  _ChangeQuantityWidgetState createState() => _ChangeQuantityWidgetState();
}

class _ChangeQuantityWidgetState extends State<ChangeQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.04,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () async {
              await CartFunctions().increaseQuantity(widget.cartId,
                  widget.data['id'], widget.data['quantity'], false);
            },
            icon: Icon(
              widget.data['quantity'].toString() == '1'
                  ? FontAwesomeIcons.trashAlt
                  : FontAwesomeIcons.minusCircle,
              color: Colors.amber,
              size: 18,
            )),
        Text(widget.data['quantity']),
        IconButton(
            onPressed: () async {
              await CartFunctions().increaseQuantity(widget.cartId,
                  widget.data['id'], widget.data['quantity'], true);
            },
            icon: Icon(
              FontAwesomeIcons.plusCircle,
              color: Colors.amber,
              size: 18,
            ))
      ]),
    );
  }
}
