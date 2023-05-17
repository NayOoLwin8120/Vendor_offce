import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/widgets.dart';

import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/category_page_controller.dart';
import 'package:vendor/pages/Category%20Page/edit_category_page.dart';

class SearchCategory extends SearchDelegate{
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


              },
            ),
          ],
        );
      },
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder<CategoryApiResponse>(
      future: _category.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final query = this.query;
          final categories = snapshot.data!.data;
          final filteredCategories = _category.filterData(query, categories);
          if(filteredCategories.isEmpty){
            return Center(child: Text("No Data Found"));
          }


          return ListView.builder(
            itemCount: filteredCategories.length,
            itemBuilder: (context, index) {
              final category = filteredCategories[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCategoryPage(id: category.id!, name: category.category_name!, imageUrl: category.category_image!),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.only(top:20,bottom: 10,right: 10,left:10),
                  color: Colors.blue.withOpacity(0.6),
                  elevation:1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width:300,
                          height:130,
                          // child:Image.network(brand.brand_image.toString())
                          child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1YSHPe4EaX_oXIXpM5PiPIRaVMOl_pTGd4Q&usqp=CAU"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding:EdgeInsets.all(8.0),
                          width:double.infinity,
                          height:40,
                          // child:Image.network(brand.brand_image.toString())
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Category name      :"),
                              Text(category.category_name.toString()),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding:EdgeInsets.all(8.0),
                          width:double.infinity,
                          height:40,
                          // child:Image.network(brand.brand_image.toString())
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("category_slug      :"),
                              Text(category.category_slug.toString()),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding:EdgeInsets.all(8.0) ,
                          width:double.infinity,
                          height:40,
                          // child:Image.network(brand.brand_image.toString())
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Category Status             :",),
                              Text(category.status == 1 ? "Active" : "inactive",style:TextStyle(color:category.status == 1 ? Colors.greenAccent : Colors.red),),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.green,
                                    elevation: 1,
                                    backgroundColor: Colors.green.withOpacity(0.6)),

                                onPressed:(){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditCategoryPage(id: category.id!, name: category.category_name!, imageUrl: category.category_image!,)),
                                  );
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
                                  _confirmDelete(context, category.id!);

                                },

                                child: const Text('Delete',style: TextStyle(fontSize: 16,color: Colors.white)),
                              ),
                            ],
                          ),


                        ),
                      ),


                    ],
                  ),
                ),
              );

              // return ListTile(
              //   title: Text(category.category_name!),
              //   onTap: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) =>
              //     //         EditCategoryPage(category: category),
              //     //   ),
              //     // );
              //     print("edit");
              //   },
              //   trailing: IconButton(
              //     icon: Icon(Icons.delete),
              //     onPressed: () {
              //       _confirmDelete(context, category.id!);
              //     },
              //   ),
              // );
            },
          );
        }

        else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder<CategoryApiResponse>(
      future: _category.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final query = this.query;
          final categories = snapshot.data!.data;
          final filteredCategories = _category.filterData(query, categories);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditCategoryPage(id: category.id!,
                                name: category.category_name!,
                                imageUrl: category.category_image!),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 10, right: 10, left: 10),
                    color: Colors.blue.withOpacity(0.6),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 300,
                            height: 130,
                            // child:Image.network(brand.brand_image.toString())
                            child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1YSHPe4EaX_oXIXpM5PiPIRaVMOl_pTGd4Q&usqp=CAU"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 40,
                            // child:Image.network(brand.brand_image.toString())
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Category name      :"),
                                Text(category.category_name.toString()),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 40,
                            // child:Image.network(brand.brand_image.toString())
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("category_slug      :"),
                                Text(category.category_slug.toString()),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 40,
                            // child:Image.network(brand.brand_image.toString())
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Category Status             :",),
                                Text(
                                  category.status == 1 ? "Active" : "inactive",
                                  style: TextStyle(
                                      color: category.status == 1 ? Colors
                                          .greenAccent : Colors.red),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.green,
                                      elevation: 1,
                                      backgroundColor: Colors.green.withOpacity(
                                          0.6)),

                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          EditCategoryPage(id: category.id!,
                                            name: category.category_name!,
                                            imageUrl: category
                                                .category_image!,)),
                                    );
                                    print("Edit Page");
                                  },
                                  child: const Text('Edit', style: TextStyle(
                                      fontSize: 16, color: Colors.white),),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.green,
                                      elevation: 1,
                                      backgroundColor: Colors.red.withOpacity(
                                          0.6)),
                                  onPressed: () {
                                    _confirmDelete(context, category.id!);
                                  },

                                  child: const Text('Delete', style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                                ),
                              ],
                            ),


                          ),
                        ),


                      ],
                    ),
                  ),
                );

                // return ListTile(
                //   title: Text(category.category_name!),
                //   onTap: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) =>
                //     //         EditCategoryPage(category: category),
                //     //   ),
                //     // );
                //     print("edit");
                //   },
                //   trailing: IconButton(
                //     icon: Icon(Icons.delete),
                //     onPressed: () {
                //       _confirmDelete(context, category.id!);
                //     },
                //   ),
                // );
              },
            );
          }
          if (filteredCategories.isEmpty) {
            return Center(child: Text("No Data Found"));
          }
        }

        else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  }
  
}