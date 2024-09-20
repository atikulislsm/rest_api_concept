import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {

  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

final TextEditingController _productNameTEController = TextEditingController();
final TextEditingController _unitPriceTEController = TextEditingController();
final TextEditingController _totalPriceTEController = TextEditingController();
final TextEditingController _productImageTEController = TextEditingController();
final TextEditingController _porductCodeTEController = TextEditingController();
final TextEditingController _porductQunatityTEController = TextEditingController();

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
bool _inprogress=false;

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Porduct'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0), child: _buildNewProductFrom()),
      ),
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
              child: const Text('Add Product'))
        ],
      ),
    );
  }
  void _onTapAddProductAddButton(){
    if(_formkey.currentState!.validate()){
      addNewProduct();
    }
  }
  Future<void>addNewProduct()async{
    _inprogress=true;
    setState(() {});
    Uri uri=Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');
    Map<String, dynamic> requestBody={
        "Img": _productImageTEController.text,
        "ProductCode": _porductCodeTEController.text,
        "ProductName": _productNameTEController.text,
        "Qty": _porductQunatityTEController.text,
        "TotalPrice": _totalPriceTEController.text,
        "UnitPrice":_unitPriceTEController.text
    };
    Response response=await post(uri,
        headers: {
      "Content-Type":"application/json"
        },
        body: jsonEncode(requestBody) );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Add Successfully')));
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed')));
    }
    _inprogress=false;
    setState(() {});
  }
  void _clearTextFields(){
    _productNameTEController.clear();
    _porductCodeTEController.clear();
    _productImageTEController.clear();
    _totalPriceTEController.clear();
    _unitPriceTEController.clear();
    _porductQunatityTEController.clear();
  }
   // @override
   // void dispose() {
   //   _porductQunatityTEController.dispose();
   //  _productNameTEController.dispose();
   //  _productImageTEController.dispose();
   //   _porductCodeTEController.dispose();
   //  _unitPriceTEController.dispose();
   //   _totalPriceTEController.dispose();
   //  super.dispose();
   // }

}
