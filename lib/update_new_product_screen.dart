import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateNewProductScreen extends StatefulWidget {
  final String productId;
  const UpdateNewProductScreen({required this.productId,super.key});

  @override
  State<UpdateNewProductScreen> createState() => _UpdateNewProductScreenState();
}

final TextEditingController _productNameTEController = TextEditingController();
final TextEditingController _unitPriceTEController = TextEditingController();
final TextEditingController _totalPriceTEController = TextEditingController();
final TextEditingController _productImageTEController = TextEditingController();
final TextEditingController _porductCodeTEController = TextEditingController();
final TextEditingController _porductQunatityTEController = TextEditingController();

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
bool _inprogress=false;

class _UpdateNewProductScreenState extends State<UpdateNewProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Prodcut'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0), child: _buildNewProductFrom()),
    );
  }

  Widget _buildNewProductFrom() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _productNameTEController,
            decoration:
                InputDecoration(hintText: 'Name', labelText: 'Porduct Name'),
          ),
          TextFormField(
            controller: _unitPriceTEController,
            decoration: InputDecoration(
                hintText: 'Unit Price', labelText: 'Unit Price'),
          ),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: InputDecoration(
                hintText: 'Total Price', labelText: 'Total Price'),
          ),
          TextFormField(
            controller: _productImageTEController,
            decoration:
                InputDecoration(hintText: 'Image', labelText: 'Prodcut Image'),
          ),
          TextFormField(
            controller: _porductCodeTEController,
            decoration:
                InputDecoration(hintText: 'Product Code', labelText: 'Code'),
          ),
          TextFormField(
            controller: _porductQunatityTEController,
            decoration:
                InputDecoration(hintText: 'Quantity', labelText: 'Quantity'),
          ),
          SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(double.maxFinite)),
              onPressed: () {
                _onTapAddProductAddButton();
              },
              child: const Text('Update Product'))
        ],
      ),
    );
  }
  void _onTapAddProductAddButton(){
    if(_formkey.currentState!.validate()){
      updateProduct();
    }

  }
  Future<void> updateProduct() async{
    setState(() {
      _inprogress=true;
    });
    Uri uri=Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.productId}');
    Map<String, dynamic> requestBody={
      "Img": _productImageTEController.text,
      "ProductCode": _porductCodeTEController.text,
      "ProductName": _productNameTEController.text,
      "Qty": _porductQunatityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };
    Response response=await post(
      uri,
      headers: {
        "Content-Type":"application/json"
      },
      body: jsonEncode(requestBody),

    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      _clearProduct();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update Successfully'))
      );
      Navigator.pop(context);

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update Failed'))
      );
    }
    _inprogress=false;
    setState(() {
    });
  }
  void _clearProduct(){
    _productNameTEController.clear();
    _productImageTEController.clear();
    _unitPriceTEController.clear();
    _porductCodeTEController.clear();
    _totalPriceTEController.clear();
    _porductQunatityTEController.clear();
  }

  // @override    (eta use kora hoyse resource khaya bose thake.. jar karone dispose kora hoy,,jate jokhn eta dorkar tokhn call kore nibe, pore dispose kore dibe)
  // void dispose() {  ( ar eta comment kore rakhsi ei jonno je jokhn back button press kore punary ei page aste chay tokhn eror dekhay jar karone apatoto comments kore rakhsi)
  //   _porductQunatityTEController.dispose();
  //   _productNameTEController.dispose();
  //   _productImageTEController.dispose();
  //   _porductCodeTEController.dispose();
  //   _unitPriceTEController.dispose();
  //   _totalPriceTEController.dispose();
  //   super.dispose();
  // }

}
