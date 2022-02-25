///搜索模型
class SearchModel {
  String? keyword;
  final List<SearchItem>? data;

  SearchModel({this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<SearchItem> data =
        dataJson.map((e) => SearchItem.fromJson(e)).toList();
    return SearchModel(data: data);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchItem {
  final String? word; //xx酒店
  final String? type; //hotel
  final String? districtname; //南京
  final String? zonename; //秦淮
  final String? url;
  final String? price; //实时计价
  final String? star; //星级

  SearchItem(
      {this.word,
      this.type,
      this.districtname,
      this.zonename,
      this.url,
      this.price,
      this.star});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json['word'],
      type: json['type'],
      districtname: json['districtname'],
      zonename: json['zonename'],
      url: json['url'],
      price: json['price'],
      star: json['star'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['word'] = word;
    data['type'] = type;
    data['districtname'] = districtname;
    data['zonename'] = zonename;
    data['url'] = url;
    data['price'] = price;
    data['star'] = star;
    return data;
  }
}
