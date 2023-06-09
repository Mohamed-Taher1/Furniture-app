import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice1/view/ui_models/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      size: 35,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 35,
                        ),
                        Text(
                          "",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Offers",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Whats New",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Hot sale",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * .9,
                  height: 180,
                  child: PageView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/4267013.jpg"),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/4267013.jpg"),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/4267013.jpg"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                child: SmoothPageIndicator(
                  effect: const SwapEffect(
                    activeDotColor: Colors.black87,
                    dotWidth: 14,
                    dotHeight: 10,
                    spacing: 4,
                  ),
                  controller: _controller,
                  count: 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                child: Text(
                  "Chair",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  height: 340,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("chairs")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text("No Data");
                        } else {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                // print(bIndex);
                                // return ProductModel(
                                //   productName:
                                //       "${docs[index]["productName"]}" ?? "",
                                //   price: "${docs[index]["price"]}" ?? "",
                                //   productType: "${docs[index]["productType"]}",
                                //   image: "${docs[index]["image"]}",
                                // );
                                return ProductModel.fromFirebase(docs, index);
                              });
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
