import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Product%20Page%20Model/product_page_model.dart';
import 'package:vendor/controllers/Product%20Page%20Controller/product_page%20_controller.dart';
import 'package:vendor/pages/Product%20Page/create_product_page.dart';
import 'package:vendor/pages/Product%20Page/image.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final ProductApiController _product=ProductApiController();

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Brand'),
          content: Text('Are you sure you want to delete this Category?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                _product.deleteProduct(id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Text('Category deleted successfully!'),
                duration: Duration(seconds: 2),
                ),
                );
                setState(() {

                });

              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateProduct()),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  ImagePickerPage()),
          // );
          // print("Route to Create");
        },
        label: const Text('Add Product'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body:
      Column(

        children: [
          SizedBox(height: 60),
          Text("Product Lists",style: TextStyle(fontSize:22 ),),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:
              Container(
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 50.0, // spacing between cards
                  runSpacing: 20.0,
                  children: [
                    FutureBuilder<ProductApiResponse>(
                      future: _product.getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: Text("Data are Loading")),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error fetching data'));
                          }
                          final apiResponse = snapshot.data!;
                          print(apiResponse.data.first.product_thambnail);
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio:1.0,
                            ),
                            itemCount: apiResponse.data.length,

                            itemBuilder: (context, index) {
                              final product= apiResponse.data[index];
                              return Card(
                                color: Colors.blue.withOpacity(0.6),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height:10),
                                    Container(
                                      width:300,
                                      height:120,
                                      // child:Image.network(brand.brand_image.toString())
                                      child:Image(
                                        width:300,
                                          height:100,
                                          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1YSHPe4EaX_oXIXpM5PiPIRaVMOl_pTGd4Q&usqp=CAU")),
                                          // image: NetworkImage("$imageip/${product.product_thambnail}")),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 250,
                                      child: Column(
                                        children: [
                                          Container(
                                            width:double.infinity,
                                            height:40,
                                             child:Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               children: [
                                                 Text("Product name:"),
                                                 Text(product.name.toString())
                                               ],
                                             )
                                          ),
                                          Container(
                                              width:double.infinity,
                                              height:40,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("Product price:"),
                                                  Text(product.selling_price.toString())
                                                ],
                                              )
                                          ),
                                          Container(
                                              width:double.infinity,
                                              height:40,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("Product Quantity:"),
                                                  Text(product.product_qty.toString())
                                                ],
                                              )
                                          ),
                                          Container(
                                              width:double.infinity,
                                              height:40,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("Discount Price"),
                                                  Text(product.discount_price.toString())
                                                ],
                                              )
                                          ),
                                          Container(
                                              width:double.infinity,
                                              height:40,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text("Product Status"),

                                                   Text(product.status == 1 ? "Active " : "InActive"),
                                                ],
                                              )
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor: Colors.green,
                                                    elevation: 1,
                                                    backgroundColor: Colors.green.withOpacity(0.6)),

                                                onPressed:(){
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) => EditSubCategoryPage(id: subcategory.id!, categoryname: subcategory.category!, subcategoryname: subcategory.subcategory_name!)),
                                                  // );
                                                  print("Edit Page");
                                                } ,
                                                child: const Text('Edit',style: TextStyle(fontSize: 16,color: Colors.white),),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor: Colors.green,
                                                    elevation: 1,
                                                    backgroundColor: Colors.red.withOpacity(0.6)),
                                                onPressed:(){
                                                  _confirmDelete(context,product.id!);

                                                },

                                                child: const Text('Delete',style: TextStyle(fontSize: 16,color: Colors.white)),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                            child: Column(
                              children: [

                                Lottie.network("https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",width: double.infinity,fit:BoxFit.fill),
                                Text('No Internet Connection',style: TextStyle(fontSize: 22,color:Colors.red),),

                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )



                  ],
                ),
              ),


            ),
          ),

        ],
      ),

    );
  }
}
