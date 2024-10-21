import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Home_Module/Home_Controller/home_controller.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  HomeController homeController = Get.put(HomeController());
  int totalItems=0;
  @override
  void initState() {

    for(int i=0;i<homeController.orderDetail.length;i++){
      totalItems=totalItems+int.parse(homeController.orderDetail[i]["quantity"].toString());
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary", style: TextStyle(color: Colors.green, fontSize: 20)),
        foregroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
              child: Card(
                color: Colors.white,
                shape: Border.all(width: 0, color: Colors.white),
                elevation: 2,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green.shade800, borderRadius: BorderRadius.all(Radius.circular(5))),
                          child:  Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("${homeController.orderDetail.length} dish - $totalItems items",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        for (int i = 0; i < homeController.orderDetail.length; i++)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        !homeController.orderDetail[i]["isVeg"]
                                            ? SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: Image.asset("assets/non_veg.png"),
                                              )
                                            : SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: Image.asset("assets/veg.png"),
                                              ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                            child: Text(
                                          homeController.orderDetail[i]["foodName"].toString(),
                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                        )),
                                        Container(
                                          height: 40,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.green.shade800, borderRadius: BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      if (homeController.orderDetail[i]["quantity"] > 0) {
                                                        homeController.orderDetail[i]["quantity"]--;
                                                        homeController.totalAmount.value=homeController.totalAmount.value-homeController.orderDetail[i]["foodPrice"];
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: const Text(
                                                      "-",
                                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                                    )),
                                                Text(
                                                  homeController.orderDetail[i]["quantity"].toString(),
                                                  style: const TextStyle(fontSize: 15, color: Colors.white),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      homeController.orderDetail[i]["quantity"]++;
                                                      homeController.totalAmount.value=homeController.totalAmount.value+homeController.orderDetail[i]["foodPrice"];
                                                      setState(() {});

                                                      print(homeController.orderDetail);
                                                    },
                                                    child: const Text(
                                                      "+",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text("${homeController.orderDetail[i]["foodPrice"]*homeController.orderDetail[i]["quantity"]}"),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 21.0),
                                      child: Text("INR ${homeController.orderDetail[i]["foodPrice"]}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 21.0),
                                      child: Text("${homeController.orderDetail[i]["foodCal"]}"),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold)),
                              Spacer(),
                              Text(
                                "INR ${homeController.totalAmount.toStringAsFixed(2)}",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 30, right: 30),
        child: InkWell(
          onTap: (){
            homeController.storeOrderDetails(totalItems: totalItems);
          },
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.green.shade800),
              width: double.infinity,
              height: 50,
              child: Center(child: Text("Place Order", style: TextStyle(fontSize: 20, color: Colors.white)))),
        ),
      ),
    );
  }
}
