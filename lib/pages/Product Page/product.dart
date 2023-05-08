import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Route to Add Product ");
        },
        label: const Text('Add Product'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(

        children: [
          SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height:20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color:Colors.deepOrangeAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Category 1")),
                          ),
                        ),
                        Card(
                          color:Colors.deepOrangeAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Category 2")),
                          ),
                        ),
                        Card(
                          color:Colors.deepOrangeAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Category 3")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                        color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 1")),
                          ),
                        ),
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product  2")),
                          ),
                        ),
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 3")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 4")),
                          ),
                        ),
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 5")),
                          ),
                        ),
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 6")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 7")),
                          ),
                        ),
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 8")),
                          ),
                        ),
                        Card(
                          color:Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Product 9")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color:Colors.deepOrangeAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Category 1")),
                          ),
                        ),
                        Card(
                          color:Colors.deepOrangeAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Category 2")),
                          ),
                        ),
                        Card(
                          color:Colors.deepOrangeAccent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            width: 120,
                            height:200,
                            child: Center(child: Text("Category 3")),
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

    );
  }
}
