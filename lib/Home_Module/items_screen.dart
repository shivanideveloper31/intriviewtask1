import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:interview_task1/Home_Module/Home_Controller/home_controller.dart';
import 'package:interview_task1/food_summary.dart';



// OrderSummary Screen (Example)
/*class AllItemsScreen extends StatelessWidget {
  final String saladName;
  final String saladDescription;
  final String saladPrice;
  final String saladCalories;
  final String saladImageUrl;

  AllItemsScreen({
    required this.saladName,
    required this.saladDescription,
    required this.saladPrice,
    required this.saladCalories,
    required this.saladImageUrl,
  });

  // Function to store order details into Firestore
  Future<void> storeOrderInFirestore(BuildContext context) async {
    await FirebaseFirestore.instance.collection('orders').add({
      'saladName': saladName,
      'saladDescription': saladDescription,
      'saladPrice': saladPrice,
      'saladCalories': saladCalories,
      'saladImageUrl': saladImageUrl,
      'orderTime': FieldValue.serverTimestamp(), // Stores current timestamp
    });

    // After storing the order, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order placed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(saladName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Price: $saladPrice'),
            Text('Calories: $saladCalories'),
            SizedBox(height: 10),
            Image.network(saladImageUrl),
            SizedBox(height: 10),
            Text(saladDescription, style: TextStyle(fontSize: 16)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                storeOrderInFirestore(context);
              },
              child: Text('Order Now'),
            ),
          ],
        ),
      ),
    );
  }
}*/

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  /*int addData = 1;

  // List of salad names
  final List<String> saladNames = [



    'Pasta Salad',
    'Chicken Salad',
    'Quinoa Salad',
    'Spinach Salad',
    'Coleslaw Salad',
  ];

  // List of salad descriptions
  final List<String> saladDescriptions = [

    'A delicious pasta salad with vegetables and Italian dressing.',
    'A protein-packed chicken salad with grapes and almonds.',
    'A nutritious quinoa salad with black beans, corn, and cilantro.',
    'A light spinach salad with strawberries and a balsamic vinaigrette.',
    'A crunchy coleslaw salad with cabbage, carrots, and a tangy dressing.',
  ];

  final List<double> sarvalue = [

    8.80,
    6.95,
    4.00,
    7.07,
    12.12,
  ];

   List<String> kCLVLU = [
    '30 calories',
    '15 calories',
    '30 calories',
    '15 calories',
    '30 calories',
  ];

  // List of image URLs corresponding to each salad
  final List<String> saladImages = [
    'https://media.istockphoto.com/id/1312863041/photo/vegan-food.jpg?s=612x612&w=0&k=20&c=DfV_HVqJvnLz3V_G5Tn4h4eL3HivJv_zLVgdAzii_Og=',
    'https://media.istockphoto.com/id/1371342734/photo/farmers-harvest-chicken-casserole.jpg?s=1024x1024&w=is&k=20&c=APbmVvOBSxLTDAL06iG3j-NFZbu2jZ0JAuVoHXeEeHg=',
    'https://media.istockphoto.com/id/619244922/photo/balsamic-chicken-with-green-beans-and-brown-rice.jpg?s=1024x1024&w=is&k=20&c=qQdGQuqGEeA9AeNxTsGEu6AXa0nH4jmmsON_rfiPYCA=',
    'https://media.istockphoto.com/id/512456968/photo/roasted-chicken-legs.jpg?s=1024x1024&w=is&k=20&c=JQ38umA-m6QgAIYcwxTQyL3oLs29CuRFAbc1FtN7nv4=',
    'https://media.istockphoto.com/id/180704962/photo/sliced-of-chicken-with-colored-rice.jpg?s=612x612&w=0&k=20&c=qZ3SjwfCxf3Lk7Nhnzb3ad7YSwqSeLLml4RQEMgfgQc=',
  ];
*/



  HomeController homeController=Get.put(HomeController());
int quentity=0;
  @override
  void initState() {
    homeController.getDataToFirebase();
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: homeController.getFoodDetails.length,
                itemBuilder: (context, index) {
                  return ListItems(foodId: homeController.getFoodDetails[index]["Id"],isVeg: homeController.getFoodDetails[index]["isVeg"],itemName: homeController.getFoodDetails[index]["foodName"],itemDescription: homeController.getFoodDetails[index]["foodDescription"],itemImage: homeController.getFoodDetails[index]["foodImg"],kclValue: homeController.getFoodDetails[index]["foodCal"],sarValue: homeController.getFoodDetails[index]["foodPrice"], quentity: quentity,);
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.green,
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                     Text("Total amount:- ${homeController.totalAmount.toStringAsFixed(2)}",style: TextStyle(color: Colors.white),),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                       await Get.to(const OrderSummary());
                        quentity=0;
                      },
                      child: Container(
                        height: 45,width: 150,
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(50))),
                      child:  const Center(child: Text("Order",style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.w800),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }




}

class ListItems extends StatefulWidget {
  String itemName;
  double sarValue;
  String kclValue;
  String itemDescription;
  String itemImage;
  String foodId;
  bool isVeg;
  int quentity;

   ListItems({super.key,required this.quentity,required this.foodId,required this.itemName,required this.sarValue,required this.kclValue,required this.itemDescription,required this.itemImage,required this.isVeg});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  HomeController homeController=Get.put(HomeController());

  int foodQuantity=0;
@override
  void initState() {
  foodQuantity=widget.quentity;
  setState(() {

  });
  // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    foodQuantity=0;
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               !widget.isVeg ?SizedBox(height: 18,width: 18,child: Image.asset("assets/non_veg.png"),):
              SizedBox(height: 18,width: 18,child: Image.asset("assets/veg.png"),),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text("SAR ${widget.sarValue}",style: TextStyle(fontWeight: FontWeight.w500,)),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(widget.kclValue,style: TextStyle(fontWeight: FontWeight.w500,)),
                        ),

                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        widget.itemDescription,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {

                                      if (foodQuantity >
                                          0) {
                                        foodQuantity--;
                                        homeController.totalAmount.value=homeController.totalAmount.value-widget.sarValue;
                                        setState(() {

                                        });
                                      }

                                  },
                                  child:const Text("-",style: TextStyle(fontSize: 30,color: Colors.white),)),
                              Text(
                                foodQuantity.toString(),
                                style: const TextStyle(fontSize: 15,color: Colors.white),
                              ),
                              InkWell(
                                  onTap: () {


                                      foodQuantity++;

                                   //  Map tempStoreData= homeController.orderDetail.firstWhere((p0) => p0["foodId"]=='FoodId1');

                                    // print(tempStoreData);
                                     //print(homeController.orderDetail[(homeController.orderDetail.indexWhere((element) => "foodId"==widget.foodId))+1]["foodId"]);
                                       if(homeController.orderDetail.isNotEmpty&&homeController.orderDetail.where((p0) => p0["foodId"]==widget.foodId).isNotEmpty) {
                                          homeController.orderDetail.removeAt(homeController.orderDetail.indexWhere((element) => "foodId"==widget.foodId)+1);
                                           homeController.orderDetail.add({
                                             "foodId": widget.foodId,
                                             "quantity": foodQuantity,
                                             "foodCal":widget.kclValue,
                                             "foodDescription":widget.itemDescription,
                                             "foodName":widget.itemName,
                                             "foodPrice":widget.sarValue,
                                             "isVeg":widget.isVeg,
                                          });
                                          setState(() {

                                          });
                                        }else{
                                          homeController.orderDetail.add({
                                            "foodId": widget.foodId,
                                            "quantity": foodQuantity,
                                            "foodCal":widget.kclValue,
                                            "foodDescription":widget.itemDescription,
                                            "foodName":widget.itemName,
                                            "foodPrice":widget.sarValue,
                                            "isVeg":widget.isVeg,
                                          });
                                          setState(() {

                                          });
                                        }
                                      homeController.totalAmount.value=homeController.totalAmount.value+widget.sarValue;
                                      print( homeController.orderDetail);


                                  },
                                  child:const Text("+",style: TextStyle(color: Colors.white,fontSize: 25,),))
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Text("Customization Available",style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),



              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.itemImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

