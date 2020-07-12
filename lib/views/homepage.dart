import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:qart_assignment/enums.dart';
import 'package:qart_assignment/models/home_page_model.dart';
import 'package:qart_assignment/service_locator.dart';
import 'package:qart_assignment/views/search_delegate_view.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: locator<HomepageModel>(),
      child: Scaffold(
        backgroundColor: Color(0XFFE2E2E2),
        body: SafeArea(
          child: ScopedModelDescendant<HomepageModel>(
            builder: (context, child, model) {
              return LiquidPullToRefresh(
                color: Colors.grey,
                animSpeedFactor: 5.0,
                onRefresh: () async {
                  await model.refresh();
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: 150.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                          child: Text(
                            "Whatcha lookin' for today?",
                            style: GoogleFonts.doHyeon(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                letterSpacing: .5,
                                fontSize: 26.0,
                              ),
                            ),
                          ),
                        ),
                        ScopedModelDescendant<HomepageModel>(
                          builder: (context, child, model) {
                            return IconButton(
                              padding: EdgeInsets.only(
                                top: 12.0,
                              ),
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                // await model.debugGetAll();
                                model.sS(context);
                                showSearch(
                                    context: context,
                                    delegate: DataSearching());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    // ScopedModelDescendant<HomepageModel>(
                    //   builder: (context, child, model) {
                    //     var n = model.getState();
                    //     if (n == bst.initial || n == bst.noresults) {
                    //       model.init();
                    //       return Text("loading image..");
                    //     } else {
                    //       String _imageurl = model.getrandomImg();
                    //       return HpDispCard(_imageurl);
                    //     }
                    //   },
                    // ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: Text(
                        "Choose from wide variety of apparels ..",
                        style: GoogleFonts.doHyeon(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: .5,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Search your style to continue!",
                        style: GoogleFonts.doHyeon(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: .5,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ScopedModelDescendant<HomepageModel>(
                      builder: (context, child, model) {
                        var n = model.getState();
                        if (n == bst.initial || n == bst.noresults) {
                          model.init();
                        }
                        if (n == bst.loaded) {
                          var _count = model.requestCount();
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Inventory Count: " + _count.toString(),
                              style: GoogleFonts.doHyeon(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 75.0),
                              child: LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.black),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    // ScopedModelDescendant<HomepageModel>(
                    //   builder: (context, child, model) {
                    //     var n = model.getState();
                    //     if (n == bst.loaded) {
                    //       return FlatButton(
                    //         onPressed: () async {
                    //           await model.clearDb();
                    //         },
                    //         child: Text(" Clear DB"),
                    //       );
                    //     } else {
                    //       return FlatButton(
                    //         onPressed: () {},
                    //         child: Text("Waiting for db to be loaded...."),
                    //       );
                    //     }
                    //   },
                    // ),
                    // ScopedModelDescendant<HomepageModel>(
                    //   builder: (context, child, model) {
                    //     var n = model.getState();
                    //     if (n == bst.loaded) {
                    //       return FlatButton(
                    //         onPressed: () async {
                    //           await model.debugGetAll();
                    //         },
                    //         child: Text(" Get all items in db"),
                    //       );
                    //     } else {
                    //       return FlatButton(
                    //         onPressed: () {},
                    //         child: Text("Waiting for db to be loaded...."),
                    //       );
                    //     }
                    //   },
                    // )
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
              IconButton(icon: Icon(Icons.history), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

// class HpDispCard extends StatelessWidget {
//   final img;
//   const HpDispCard(this.img);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 250,
//         width: 200,
//         color: Color(0XFFCFDFAC),
//         margin: EdgeInsets.all(16.0),
//         padding: EdgeInsets.all(16.0),
//         child: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Image.network(this.img),
//         ));
//   }
// }
