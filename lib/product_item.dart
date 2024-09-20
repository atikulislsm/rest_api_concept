import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_concept/deleteProduct.dart';
import 'package:rest_api_concept/update_new_product_screen.dart';

import 'model/product.dart';

class productItem extends StatefulWidget {
  const productItem({
    super.key,
    required this.product,
  });

  final Product product;
  

  @override
  State<productItem> createState() => _productItemState();
}
final TextEditingController _productNameTEController = TextEditingController();
final TextEditingController _unitPriceTEController = TextEditingController();
final TextEditingController _totalPriceTEController = TextEditingController();
final TextEditingController _productImageTEController = TextEditingController();
final TextEditingController _porductCodeTEController = TextEditingController();
final TextEditingController _porductQunatityTEController = TextEditingController();
final GlobalKey<FormState> _fromKey=GlobalKey<FormState>();
bool _inprogress=true;


class _productItemState extends State<productItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(widget.product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${widget.product.prodcutCode}'),
          Text('Price: \$${widget.product.unitPrice}'),
          Text('Quantity: ${widget.product.quantitiy}'),
          Text('Total Price: \$${widget.product.totalPrice}'),
          Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UpdateNewProductScreen(
                      productId: widget.product.id,
                    );
                  }));
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DeleteproductScreen(productID: widget.product.id,);
                  }));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
