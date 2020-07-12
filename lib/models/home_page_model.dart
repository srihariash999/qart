import 'dart:convert';

import 'package:qart_assignment/db/dbMain.dart';
import 'package:qart_assignment/enums.dart';
import 'package:qart_assignment/service_locator.dart';
import 'package:qart_assignment/services/homepage_service.dart';
import 'package:scoped_model/scoped_model.dart';

List suggestionsDummy = ["one", "two", "three"];
List<DbModel> _data1 = [];
List<DbModel> _dataOrig = [];
String _warningImg =
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fwarning&psig=AOvVaw1j4ih9flHyNj_TthG3zxgG&ust=1594633654146000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKCDnra3x-oCFQAAAAAdAAAAABAD";
var resultsIndex;

class HomepageModel extends Model {
  HomepageService _hpService = locator<HomepageService>();

  bst _state = bst.initial;

  getState() => _state;

  requestCount() {
    return _hpService.getCount();
  }

  getrandomImg() {
    String _i = _hpService.getRandomImage();
    return _i;
  }

  debugGetAll() async {
    await _hpService.getAll();
  }

  clearDb() async {
    _hpService.cleardb();
  }

  getData1Length() {
    return _data1.length;
  }

  getDispName(i) {
    return _data1[i].toMap()[columnName];
  }

  getDispImage(i) {
    return _data1[i].toMap()[columnImageUrl] == null
        ? _warningImg
        : _data1[i].toMap()[columnImageUrl];
  }

  getResImage() {
    return resultsIndex.toMap()[columnImageUrl];
  }

  getResOption() {
    return resultsIndex.toMap()[columnOption];
  }

  getResColor() {
    return resultsIndex.toMap()[columnColor];
  }

  getResMrp() {
    return resultsIndex.toMap()[columnMrp];
  }

  getResBrand() {
    return resultsIndex.toMap()[columnBrand];
  }

  getResCategory() {
    return resultsIndex.toMap()[columnCategory];
  }

  getResCollection() {
    return resultsIndex.toMap()[columnCollection];
  }

  getResGender() {
    return resultsIndex.toMap()[columnGender];
  }

  getResSubCategory() {
    return resultsIndex.toMap()[columnSubCategory];
  }

  getResName() {
    return resultsIndex.toMap()[columnName];
  }

  getResDescription() {
    return resultsIndex.toMap()[columnDescription];
  }

  getResMaterial() {
    return resultsIndex.toMap()[columnMaterial];
  }

  getResSeason() {
    return resultsIndex.toMap()[columnSeason];
  }

  getTheme() {
    return resultsIndex.toMap()[columnTheme];
  }

  getFinish() {
    return resultsIndex.toMap()[columnFinish];
  }

  getResrating() {
    var n = double.parse(resultsIndex.toMap()[columnLikeability]) / 2;
    print(n);
    return n;
  }

  getDispQr(i) {
    return _data1[i].toMap()[columnQrCode];
  }

  getDispColor(i) {
    return _data1[i].toMap()[columnColor];
  }

  getDispOption(i) {
    return _data1[i].toMap()[columnOption];
  }

  getDispMrp(i) {
    return _data1[i].toMap()[columnMrp];
  }

  getDispEan(i) {
    var _d = _data1[i].toMap()[columnEan];
    _d = jsonDecode(_d);
    return _d;
  }

  triggerResults(i) {
    var _o;
    for (var item in _dataOrig) {
      if (item.toMap()[columnOption] == i) {
        _o = item;
      }
    }
    resultsIndex = _o;
  }

  filterList(query) {
    _data1 = [];
    for (var item in _dataOrig) {
      if (item.toMap()[columnQrCode].startsWith(query) ||
          item.toMap()[columnOption].startsWith(query)) {
        _data1.add(item);
      }
    }
    {}
  }

  sS(context) async {
    _dataOrig = await _hpService.getAll();
    _data1 = _dataOrig;
  }

refresh()async{
  _hpService.setToInit();
   _state = bst.loading;
    notifyListeners();
    var l = _hpService.ifInit();
    if (l == "...") {
      print("init is :  $l");

      String _i = await _hpService.loadUrls();
      print(_i);
      _state = bst.loaded;
      notifyListeners();
    } else {
      _state = bst.loaded;
      notifyListeners();
    }
}


  init() async {
    _state = bst.loading;
    notifyListeners();
    var l = _hpService.ifInit();
    if (l == "...") {
      print("init is :  $l");

      String _i = await _hpService.loadUrls();
      print(_i);
      _state = bst.loaded;
      notifyListeners();
    } else {
      _state = bst.loaded;
      notifyListeners();
    }
  }
}
