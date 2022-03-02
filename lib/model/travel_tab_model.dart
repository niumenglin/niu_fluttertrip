///旅拍类别模型
class TravelTabModel {
  String? url;
  Params? params;
  List<TravelTab>? tabs;

  TravelTabModel({this.url, this.params, this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    if (json['tabs'] != null) {
      tabs = <TravelTab>[];
      json['tabs'].forEach((v) {
        tabs!.add(TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    if (params != null) {
      data['params'] = params!.toJson();
    }
    if (tabs != null) {
      data['tabs'] = tabs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Params {
  int? districtId;
  String? groupChannelCode;
  String? type;
  int? lat;
  int? lon;
  int? locatedDistrictId;
  PagePara? pagePara;
  int? imageCutType;
  Head? head;
  String? contentType;

  Params(
      {this.districtId,
      this.groupChannelCode,
      this.type,
      this.lat,
      this.lon,
      this.locatedDistrictId,
      this.pagePara,
      this.imageCutType,
      this.head,
      this.contentType});

  Params.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    groupChannelCode = json['groupChannelCode'];
    type = json['type'];
    lat = json['lat'];
    lon = json['lon'];
    locatedDistrictId = json['locatedDistrictId'];
    pagePara =
        json['pagePara'] != null ? PagePara.fromJson(json['pagePara']) : null;
    imageCutType = json['imageCutType'];
    head = json['head'] != null ? Head.fromJson(json['head']) : null;
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['districtId'] = districtId;
    data['groupChannelCode'] = groupChannelCode;
    data['type'] = type;
    data['lat'] = lat;
    data['lon'] = lon;
    data['locatedDistrictId'] = locatedDistrictId;
    if (pagePara != null) {
      data['pagePara'] = pagePara!.toJson();
    }
    data['imageCutType'] = imageCutType;
    if (head != null) {
      data['head'] = head!.toJson();
    }
    data['contentType'] = contentType;
    return data;
  }
}

class PagePara {
  int? pageIndex;
  int? pageSize;
  int? sortType;
  int? sortDirection;

  PagePara({this.pageIndex, this.pageSize, this.sortType, this.sortDirection});

  PagePara.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sortType = json['sortType'];
    sortDirection = json['sortDirection'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['sortType'] = sortType;
    data['sortDirection'] = sortDirection;
    return data;
  }
}

class Head {
  String? cid;
  String? ctok;
  String? cver;
  String? lang;
  String? sid;
  String? syscode;
  String? auth;
  List<Extension>? extension;

  Head(
      {this.cid,
      this.ctok,
      this.cver,
      this.lang,
      this.sid,
      this.syscode,
      this.auth,
      this.extension});

  Head.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    ctok = json['ctok'];
    cver = json['cver'];
    lang = json['lang'];
    sid = json['sid'];
    syscode = json['syscode'];
    auth = json['auth'];
    if (json['extension'] != null) {
      extension = <Extension>[];
      json['extension'].forEach((v) {
        extension!.add(Extension.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cid'] = cid;
    data['ctok'] = ctok;
    data['cver'] = cver;
    data['lang'] = lang;
    data['sid'] = sid;
    data['syscode'] = syscode;
    data['auth'] = auth;
    if (extension != null) {
      data['extension'] = extension!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extension {
  String? name;
  String? value;

  Extension({this.name, this.value});

  Extension.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class TravelTab {
  String? labelName;
  String? groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['labelName'] = labelName;
    data['groupChannelCode'] = groupChannelCode;
    return data;
  }
}
