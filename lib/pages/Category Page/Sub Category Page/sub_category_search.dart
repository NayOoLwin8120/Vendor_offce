import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/Sub_Category%20Page%20Model/sub_category_page_model.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/Sub_Category%20Page%20Controller/sub_category_page_controller.dart';
import 'package:vendor/pages/Category%20Page/Sub%20Category%20Page/edit_sub_category_page.dart';

class SubCategorySearch extends SearchDelegate{
  final SubCategoryApiController _subcategory=SubCategoryApiController();

  void _confirmDelete(BuildContext context, int? id) {
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
                _subcategory.deleteSubCategory(id);
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
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {

        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FutureBuilder<SubCategoryApiResponse>(
        future: _subcategory.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final query = this.query;
            final categories = snapshot.data!.data;
            final filteredCategories = _subcategory.filterData(query, categories);
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
            if(filteredCategories.isEmpty){
              return Center(
                child: Text(
                  "No Data Found !",
                  style: TextStyle(fontSize: 26),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error fetching data'));
            }
            final apiResponse = snapshot.data!;
            print(apiResponse.data.first.id);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.3,
              ),
              // itemCount: apiResponse.data.length,
              itemCount: filteredCategories.length,

              itemBuilder: (context, index) {
                final subcategory = filteredCategories[index];
                final number=index+1;
                // print(number);
                return Card(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding:EdgeInsets.all(8.0),
                          width:double.infinity,
                          height:40,
                          // child:Image.network(brand.brand_image.toString())
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub_category name      :"),
                              Text(subcategory.subcategory_name.toString()),
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
                              Text("Sub_category_slug      :"),
                              Text(subcategory.subcategory_slug.toString()),
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
                              Text("Category name              :",),
                              Text(subcategory.category.toString()),
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                                  MaterialPageRoute(builder: (context) => EditSubCategoryPage(id: subcategory.id!, categoryname: subcategory.category!, subcategoryname: subcategory.subcategory_name!)),
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
                                _confirmDelete(context, subcategory.id!);

                              },

                              child: const Text('Delete',style: TextStyle(fontSize: 16,color: Colors.white)),
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
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // return SingleChildScrollView(
    //   scrollDirection: Axis.vertical,
    //   child: FutureBuilder<SubCategoryApiResponse>(
    //     future: _subcategory.getData(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         final query = this.query;
    //         final categories = snapshot.data!.data;
    //         final filteredCategories = _subcategory.filterData(query, categories);
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Center(child: Text("Data are Loading")),
    //                 Center(child: CircularProgressIndicator()),
    //               ],
    //             ),
    //           );
    //         }
    //         if(filteredCategories.isEmpty){
    //           return Center(
    //             child: Text(
    //               "No Data Found !",
    //               style: TextStyle(fontSize: 26),
    //             ),
    //           );
    //         }
    //         if (snapshot.hasError) {
    //           return Center(child: Text('Error fetching data'));
    //         }
    //         final apiResponse = snapshot.data!;
    //         print(apiResponse.data.first.id);
    //         return GridView.builder(
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 1,
    //             childAspectRatio: 1.3,
    //           ),
    //           // itemCount: apiResponse.data.length,
    //           itemCount: filteredCategories.length,
    //
    //           itemBuilder: (context, index) {
    //             final subcategory = filteredCategories[index];
    //             final number=index+1;
    //             // print(number);
    //             return Card(
    //               color: Colors.blue.withOpacity(0.6),
    //               elevation:1,
    //               shape: RoundedRectangleBorder(
    //                 side: BorderSide(
    //                   color: Theme.of(context).colorScheme.outline,
    //                 ),
    //                 borderRadius: const BorderRadius.all(Radius.circular(12)),
    //               ),
    //               child: Column(
    //                 children: [
    //
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Container(
    //                       padding:EdgeInsets.all(8.0),
    //                       width:double.infinity,
    //                       height:40,
    //                       // child:Image.network(brand.brand_image.toString())
    //                       child:Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text("Sub_category name      :"),
    //                           Text(subcategory.subcategory_name.toString()),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(10.0),
    //                     child: Container(
    //                       padding:EdgeInsets.all(8.0),
    //                       width:double.infinity,
    //                       height:40,
    //                       // child:Image.network(brand.brand_image.toString())
    //                       child:Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text("Sub_category_slug      :"),
    //                           Text(subcategory.subcategory_slug.toString()),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Container(
    //                       padding:EdgeInsets.all(8.0) ,
    //                       width:double.infinity,
    //                       height:40,
    //                       // child:Image.network(brand.brand_image.toString())
    //                       child:Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text("Category name              :",),
    //                           Text(subcategory.category.toString()),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     width: double.infinity,
    //                     height: 40,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         TextButton(
    //                           style: TextButton.styleFrom(
    //                               foregroundColor: Colors.green,
    //                               elevation: 1,
    //                               backgroundColor: Colors.green.withOpacity(0.6)),
    //
    //                           onPressed:(){
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(builder: (context) => EditSubCategoryPage(id: subcategory.id!, categoryname: subcategory.category!, subcategoryname: subcategory.subcategory_name!)),
    //                             );
    //                             print("Edit Page");
    //                           } ,
    //                           child: const Text('Edit',style: TextStyle(fontSize: 16,color: Colors.white),),
    //                         ),
    //                         TextButton(
    //                           style: TextButton.styleFrom(
    //                               foregroundColor: Colors.green,
    //                               elevation: 1,
    //                               backgroundColor: Colors.red.withOpacity(0.6)),
    //                           onPressed:(){
    //                             _confirmDelete(context, subcategory.id!);
    //
    //                           },
    //
    //                           child: const Text('Delete',style: TextStyle(fontSize: 16,color: Colors.white)),
    //                         ),
    //                       ],
    //                     ),
    //
    //
    //                   ),
    //
    //
    //                 ],
    //               ),
    //             );
    //           },
    //         );
    //
    //       }
    //       else if (snapshot.hasError) {
    //         print(snapshot.error);
    //         return Center(
    //           child: Column(
    //             children: [
    //
    //               Lottie.network("https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",width: double.infinity,fit:BoxFit.fill),
    //               Text('No Internet Connection',style: TextStyle(fontSize: 22,color:Colors.red),),
    //
    //             ],
    //           ),
    //         );
    //       }
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     },
    //   ),
    // );

    return Text("Search");
  }


}





