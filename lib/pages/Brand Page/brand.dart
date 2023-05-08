

import 'package:flutter/material.dart';
import 'package:vendor/Model/Brand%20Page%20Model%20/brand_model.dart';
import 'package:vendor/controllers/Brand%20Page%20Controller/brand_controller.dart';
import 'package:vendor/pages/Brand%20Page/create_brand.dart';
import 'package:vendor/pages/Brand%20Page/editbrand.dart';
import 'package:lottie/lottie.dart';

class Brand extends StatefulWidget{
  const Brand({Key? key}) : super(key: key);

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
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
            MaterialPageRoute(builder: (context) => const CreateBrandPage()),
          );
        },
        label: const Text('Add Brand'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body:
      Column(

        children: [
          SizedBox(height: 60),
          Text("Brand Lists",style: TextStyle(fontSize:22 ),),
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
                        FutureBuilder<BrandApiResponse>(
                          future: _brand.getData(),
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
                              print(apiResponse.data.first.brand_image);
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                ),
                                itemCount: apiResponse.data.length,

                                itemBuilder: (context, index) {
                                  final brand = apiResponse.data[index];
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
