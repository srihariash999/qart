import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:qart_assignment/models/home_page_model.dart';
import 'package:qart_assignment/service_locator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DataSearching extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ScopedModel<HomepageModel>(
      model: locator<HomepageModel>(),
      child: ScopedModelDescendant<HomepageModel>(
        builder: (context, child, model) {
          return ExpandableBottomSheet(
            background: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10.0),
              itemCount: 30,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 2.0,
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.network(
                                  model.getResImage(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Opacity(
                                  opacity: 0.50,
                                  child: Container(
                                    height: 50.0,
                                    width: double.infinity,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50.0,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          model.getResOption(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          model.getResColor(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          model.getResMrp(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: model.getResrating(),
                            size: 18.0,
                            isReadOnly: true,
                            color: Colors.green,
                            borderColor: Colors.green,
                            spacing: 0.0),
                      )
                    ],
                  ),
                );
              },
            ),
            persistentHeader: Container(
              height: 40,
              color: Colors.black54,
              child: Center(
                child: Text(
                  'Details',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            expandableContent: Container(
              color: Colors.grey,
              height: 700,
              child: Center(
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Brand_Category_Collection:",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                model.getResBrand() +
                                    "  -  " +
                                    model.getResCategory() +
                                    "  -  " +
                                    model.getResCollection(),
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Gender_Name_SubCategory",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                model.getResGender() +
                                    "  -  " +
                                    model.getResName() +
                                    "  -  " +
                                    model.getResSubCategory(),
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Theme_Finish:",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                model.getTheme() + "  -  " + model.getFinish(),
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Description",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    model.getResDescription(),
                                    softWrap: true,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Material",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    model.getResMaterial(),
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Season",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    model.getResSeason(),
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ScopedModel<HomepageModel>(
      model: locator<HomepageModel>(),
      child: ScopedModelDescendant<HomepageModel>(
        builder: (context, child, model) {
          model.filterList(query);

          return ListView.separated(
            itemCount: model.getData1Length(),
            itemBuilder: (context, i) {
              // var _name = model.getDispName(i);
              var _img = model.getDispImage(i);
              var _qr = model.getDispQr(i);
              var _color = model.getDispColor(i);
              var _option = model.getDispOption(i);
              var _mrp = model.getDispMrp(i);
              var _eanList = model.getDispEan(i);
              return GestureDetector(
                onTap: () {
                  model.triggerResults(_option);
                  showResults(context);
                },
                child: Container(
                  height: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          _qr,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Image.network(
                              _img,
                              errorBuilder: (context, _, __) {
                                return Text("no Img");
                              },
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Color: " + _color,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "OP: " + _option,
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "MAX: " + _mrp,
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 80.0,
                              width: 118.0,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10.0),
                                itemCount: _eanList.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 5.0,
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(_eanList[index]);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, i) {
              return Divider(
                color: Colors.grey,
              );
            },
          );
        },
      ),
    );
  }
}
