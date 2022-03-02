///旅拍页模型
class TravelModel {
  int? totalCount;
  List<TravelItem>? resultList;

  TravelModel({this.totalCount, this.resultList});

  TravelModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = <TravelItem>[];
      json['resultList'].forEach((v) {
        resultList!.add(TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (resultList != null) {
      data['resultList'] = resultList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelItem {
  int? type;
  Article? article;

  TravelItem({this.type, this.article});

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article =
        json['article'] != null ? Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (article != null) {
      data['article'] = article!.toJson();
    }
    return data;
  }
}

class Article {
  int? articleId;
  String? articleType;
  int? productType;
  int? sourceType;
  String? articleTitle;
  Author? author;
  List<Images>? images;
  bool? hasVideo;
  int? readCount;
  int? likeCount;
  int? commentCount;
  List<Urls>? urls;
  List<Topics>? topics;
  List<Pois>? pois;
  String? publishTime;
  String? publishTimeDisplay;
  String? shootTime;
  String? shootTimeDisplay;
  int? level;
  String? distanceText;
  bool? isLike;
  int? imageCounts;
  bool? isCollected;
  int? collectCount;
  int? articleStatus;
  String? poiName;

  Article(
      {this.articleId,
      this.articleType,
      this.productType,
      this.sourceType,
      this.articleTitle,
      this.author,
      this.images,
      this.hasVideo,
      this.readCount,
      this.likeCount,
      this.commentCount,
      this.urls,
      this.topics,
      this.pois,
      this.publishTime,
      this.publishTimeDisplay,
      this.shootTime,
      this.shootTimeDisplay,
      this.level,
      this.distanceText,
      this.isLike,
      this.imageCounts,
      this.isCollected,
      this.collectCount,
      this.articleStatus,
      this.poiName});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    articleType = json['articleType'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(Urls.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = <Pois>[];
      json['pois'].forEach((v) {
        pois!.add(Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['articleId'] = articleId;
    data['articleType'] = articleType;
    data['productType'] = productType;
    data['sourceType'] = sourceType;
    data['articleTitle'] = articleTitle;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = hasVideo;
    data['readCount'] = readCount;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    if (urls != null) {
      data['urls'] = urls!.map((v) => v.toJson()).toList();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (pois != null) {
      data['pois'] = pois!.map((v) => v.toJson()).toList();
    }
    data['publishTime'] = publishTime;
    data['publishTimeDisplay'] = publishTimeDisplay;
    data['shootTime'] = shootTime;
    data['shootTimeDisplay'] = shootTimeDisplay;
    data['level'] = level;
    data['distanceText'] = distanceText;
    data['isLike'] = isLike;
    data['imageCounts'] = imageCounts;
    data['isCollected'] = isCollected;
    data['collectCount'] = collectCount;
    data['articleStatus'] = articleStatus;
    data['poiName'] = poiName;
    return data;
  }
}

class Author {
  int? authorId;
  String? nickName;
  String? clientAuth;
  String? jumpUrl;
  CoverImage? coverImage;
  int? identityType;
  String? tag;

  Author(
      {this.authorId,
      this.nickName,
      this.clientAuth,
      this.jumpUrl,
      this.coverImage,
      this.identityType,
      this.tag});

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    identityType = json['identityType'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['authorId'] = authorId;
    data['nickName'] = nickName;
    data['clientAuth'] = clientAuth;
    data['jumpUrl'] = jumpUrl;
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    data['identityType'] = identityType;
    data['tag'] = tag;
    return data;
  }
}

class CoverImage {
  String? dynamicUrl;
  String? originalUrl;

  CoverImage({this.dynamicUrl, this.originalUrl});

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    return data;
  }
}

class Images {
  int? imageId;
  String? dynamicUrl;
  String? originalUrl;
  int? width;
  int? height;
  int? mediaType;
  bool? isWaterMarked;

  Images(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height,
      this.mediaType,
      this.isWaterMarked});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    data['width'] = width;
    data['height'] = height;
    data['mediaType'] = mediaType;
    data['isWaterMarked'] = isWaterMarked;
    return data;
  }
}

class Urls {
  String? version;
  String? appUrl;
  String? h5Url;
  String? wxUrl;

  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['appUrl'] = appUrl;
    data['h5Url'] = h5Url;
    data['wxUrl'] = wxUrl;
    return data;
  }
}

class Topics {
  int? topicId;
  String? topicName;
  int? level;

  Topics({this.topicId, this.topicName, this.level});

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    data['level'] = level;
    return data;
  }
}

class Pois {
  int? poiType;
  int? poiId;
  String? poiName;
  int? businessId;
  int? districtId;
  PoiExt? poiExt;
  int? source;
  int? isMain;
  bool? isInChina;
  String? countryName;

  Pois(
      {this.poiType,
      this.poiId,
      this.poiName,
      this.businessId,
      this.districtId,
      this.poiExt,
      this.source,
      this.isMain,
      this.isInChina,
      this.countryName});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    poiExt = json['poiExt'] != null ? PoiExt.fromJson(json['poiExt']) : null;
    source = json['source'];
    isMain = json['isMain'];
    isInChina = json['isInChina'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['poiType'] = poiType;
    data['poiId'] = poiId;
    data['poiName'] = poiName;
    data['businessId'] = businessId;
    data['districtId'] = districtId;
    if (poiExt != null) {
      data['poiExt'] = poiExt!.toJson();
    }
    data['source'] = source;
    data['isMain'] = isMain;
    data['isInChina'] = isInChina;
    data['countryName'] = countryName;
    return data;
  }
}

class PoiExt {
  String? h5Url;
  String? appUrl;

  PoiExt({this.h5Url, this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['h5Url'] = h5Url;
    data['appUrl'] = appUrl;
    return data;
  }
}
