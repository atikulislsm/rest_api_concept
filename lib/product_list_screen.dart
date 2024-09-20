import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_concept/add_new_product_screen.dart';
import 'package:rest_api_concept/model/product.dart';
import 'package:rest_api_concept/product_item.dart';
import 'package:rest_api_concept/update_new_product_screen.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> prodcutList = [];
  bool _inprogress=false;


  @override
  void initState() {
    super.initState();
    getProductList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product list'),
        actions: [
          IconButton(onPressed: (){
            getProductList();
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: _inprogress ? const Center(
        child: CircularProgressIndicator(),
      ): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: prodcutList.length,
          itemBuilder: (contex, index) {
            return  productItem(product: prodcutList[index] );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16);
          },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddNewProductScreen();
          })
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getProductList() async {
    _inprogress=true;
    setState(() {
    });

    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      prodcutList.clear();
      Map<String, dynamic> jsnResponse = jsonDecode(response.body);
      for (var item in jsnResponse['data']) {
        Product product = Product(
            id: item['_id'],
            productName: item['ProductName'] ?? '',
            prodcutCode: item['ProductCode']?? '',
            producttImage: item['Img']?? '',
            unitPrice: item['UnitPrice'] ?? '',
            quantitiy: item['Qty' ] ?? '',
            totalPrice: item['TotalPrice'] ?? '',
            createdAt: item['CreatedDate'] ?? ''
        );
        prodcutList.add(product);
      }
    }
    _inprogress=false;
    setState(() {
    });
  }

}

