import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DeleteproductScreen extends StatefulWidget {
  final String productID;
  const DeleteproductScreen({super.key, required this.productID});

  @override
  State<DeleteproductScreen> createState() => _DeleteproductScreenState();
}
final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
bool _inprogrees=true;

class _DeleteproductScreenState extends State<DeleteproductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Prodcut'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child:_buildDeleteProductFrom()
        ),
      ),
    );
  }
  Widget _buildDeleteProductFrom(){
    return Center(
      child: Form(
        key: _formKey,
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                _onTapDeleteProdcut();
              }, child: Text('Delete'))
            ],
          ),
      ),
    );
  }
  void _onTapDeleteProdcut(){
    if(_formKey.currentState!.validate()){
      deleteProduct();
    }
  }
  Future<void> deleteProduct() async{
    setState(() {
      _inprogrees=true;
    });
    Uri uri=Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/${widget.productID}');
    Response response=await get(uri, headers: {"Content-Type":"application/json"});
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Sucessfully')));
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Failed')));
    }
    _inprogrees=false;
    setState(() {});
  }
}
