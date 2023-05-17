

import 'package:flutter/material.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';

import 'package:lottie/lottie.dart';
import 'package:vendor/pages/Category%20Page/category_search_page.dart';
import 'package:vendor/pages/Category%20Page/create_category_page.dart';
import 'package:vendor/pages/Category%20Page/edit_category_page.dart';

import '../../controllers/Category Page Controller/category_page_controller.dart';

class Category_page extends StatefulWidget{
  const Category_page({Key? key}) : super(key: key);

  @override
  State<Category_page> createState() => _Category_pageState();
}

class _Category_pageState extends State<Category_page> {
  final CategoryApiController _category= CategoryApiController();



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
                _category.deleteCategory(id);
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
            MaterialPageRoute(builder: (context) => const CreateCategoryPage()),
          );
        },
        label: const Text('Add Category'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body:
      Column(

        children: [
          SizedBox(height: 60),
          Text("Category Lists",style: TextStyle(fontSize:22 ),),
          SizedBox(height:20),
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
                    FutureBuilder<CategoryApiResponse>(
                      // future: _category.getData(),
                      future: _category.getData(),
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
                          print(apiResponse.data.first.category_image);
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: apiResponse.data.length,

                            itemBuilder: (context, index) {
                              final category = apiResponse.data[index];
                              return Card(
                                color: Colors.white38,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width:300,
                                      height:130,
                                      // child:Image.network(brand.brand_image.toString())
                                      child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1YSHPe4EaX_oXIXpM5PiPIRaVMOl_pTGd4Q&usqp=CAU"),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Center(child: Text(category.category_name.toString(),style: TextStyle(fontSize: 20),)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(

                                                onPressed:(){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => EditCategoryPage (id: category.id!, name: category.category_name!, imageUrl:category.category_image!)),
                                                  );
                                                } ,
                                                child: const Text('Edit',style: TextStyle(fontSize: 20,color: Colors.green),),
                                              ),
                                              TextButton(

                                                onPressed:(){
                                                  _confirmDelete(context, category.id!);
                                                },
                                                child: const Text('Delete',style: TextStyle(fontSize: 20,color: Colors.red)),
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
