import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Brand%20Page%20Model%20/brand_model.dart';
import 'package:vendor/controllers/Brand%20Page%20Controller/brand_controller.dart';
import 'package:vendor/pages/Brand%20Page/editbrand.dart';

class SearchBrandPage extends  SearchDelegate{
  final BrandApiController _brand=BrandApiController();
  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Brand'),
          content: Text('Are you sure you want to delete this brand?'),
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
                _brand.deleteBrand(id,);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Brand deleted successfully!'),
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
    return FutureBuilder<BrandApiResponse>(
      future: _brand.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final query = this.query;
          final brands = snapshot.data!.data;
          final filteredBrands = _brand.filterData(query, brands);
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
          if(filteredBrands.isEmpty){
            return Center(child: Text("No Data Found !",style: TextStyle(fontSize: 26),));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }
          final apiResponse = snapshot.data!;
          print(apiResponse.data.first.brand_image);
          return GridView.builder(
            shrinkWrap: true,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.8,
            ),

            // itemCount: apiResponse.data.length,
            itemCount: filteredBrands.length,

            itemBuilder: (context, index) {
              final brand = apiResponse.data[index];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
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
                        // child:Image.network(brand.brand_image.toString()),
                        child:Image.network("https://upload.wikimedia.org/wikipedia/commons/9/99/LEI0440_Leica_IIIf_chrom_-_Sn._580566_1951-52-M39_Blitzsynchron_front_view-6531_hf-.jpg"),
                      ),
                      Container(
                        width: 300,
                        height: 100,
                        child: Column(
                          children: [
                            Center(child: Text(brand.brand_name.toString(),style: TextStyle(fontSize: 20),)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(

                                  onPressed:(){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  EditBrand(id: brand.id!, name: brand.brand_name!, imageUrl:brand.brand_image!)),
                                    );
                                  } ,
                                  child: const Text('Edit',style: TextStyle(fontSize: 20,color: Colors.green),),
                                ),
                                TextButton(

                                  onPressed:(){
                                    _confirmDelete(context, brand.id!);
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
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   return Center(
  //     child: Text('Search Brand '),
  //   );
  // }
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<BrandApiResponse>(
      future: _brand.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final query = this.query;
          final brands = snapshot.data!.data;
          final filteredBrands = _brand.filterData(query, brands);
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
          if(filteredBrands.isEmpty){
            return Center(child: Text("No Data Found !",style: TextStyle(fontSize: 26),));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }
          final apiResponse = snapshot.data!;
          print(apiResponse.data.first.brand_image);
          return GridView.builder(
            shrinkWrap: true,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.8,
            ),

            // itemCount: apiResponse.data.length,
            itemCount: filteredBrands.length,

            itemBuilder: (context, index) {
              final brand = apiResponse.data[index];
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
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
                        // child:Image.network(brand.brand_image.toString()),
                        child:Image.network("https://upload.wikimedia.org/wikipedia/commons/9/99/LEI0440_Leica_IIIf_chrom_-_Sn._580566_1951-52-M39_Blitzsynchron_front_view-6531_hf-.jpg"),
                      ),
                      Container(
                        width: 300,
                        height: 100,
                        child: Column(
                          children: [
                            Center(child: Text(brand.brand_name.toString(),style: TextStyle(fontSize: 20),)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(

                                  onPressed:(){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  EditBrand(id: brand.id!, name: brand.brand_name!, imageUrl:brand.brand_image!)),
                                    );
                                  } ,
                                  child: const Text('Edit',style: TextStyle(fontSize: 20,color: Colors.green),),
                                ),
                                TextButton(

                                  onPressed:(){
                                    _confirmDelete(context, brand.id!);
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
    );
  }
  
}