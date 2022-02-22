import 'dart:convert';

class TravelItem {
  int type;

  Article article;

  TravelItem({required this.type, required this.article});

  factory TravelItem.fromJson(Map<String, dynamic> json) {
    Article article = Article.fromJson(json['article']);
    return TravelItem(type: json['type'], article: article);
  }

  Map<String, dynamic> toJson() {
    return {"type": type, "article": json.encode(article)};
  }
}

class Article {
  int articleId;
  int productType;
  int sourceType;
  String articleTitle;
  Author author;
  List<Images> images;
  bool hasVideo;
  int readCount;
  int likeCount;
  int commentCount;
  List<Urls> urls;
  List<Pois> pois;
  String publishTime;
  String publishTimeDisplay;
  String shootTime;
  String shootTimeDisplay;
  int level;
  String distanceText;
  bool isLike;
  int imageCounts;
  bool isCollected;
  int collectCount;

  Article(
      {required this.articleId,
      required this.productType,
      required this.sourceType,
      required this.articleTitle,
      required this.author,
      required this.images,
      required this.hasVideo,
      required this.readCount,
      required this.likeCount,
      required this.commentCount,
      required this.urls,
      required this.pois,
      required this.publishTime,
      required this.publishTimeDisplay,
      required this.shootTime,
      required this.shootTimeDisplay,
      required this.level,
      required this.distanceText,
      required this.isLike,
      required this.imageCounts,
      required this.isCollected,
      required this.collectCount});

  factory Article.fromJson(Map<String, dynamic> json) {
    Author author = Author.fromJson(json['author']);
    List<Images> images = (json['images'] as List).map((v) {
      return Images.fromJson(v);
    }).toList();
    List<Urls> urls = (json['urls'] as List).map((v) {
      return Urls.fromJson(v);
    }).toList();
    List<Pois> pois = (json['pois'] as List).map((v) {
      return Pois.fromJson(v);
    }).toList();
    return Article(
        articleId: json['articleId'],
        productType: json['productType'],
        sourceType: json['sourceType'],
        articleTitle: json['articleTitle'],
        author: author,
        images: images,
        hasVideo: json['hasVideo'],
        readCount: json['readCount'],
        likeCount: json['likeCount'],
        commentCount: json['commentCount'],
        urls: urls,
        pois: pois,
        publishTime: json['publishTime'],
        publishTimeDisplay: json['publishTimeDisplay'],
        shootTime: json['shootTime'],
        shootTimeDisplay: json['shootTimeDisplay'],
        level: json['level'],
        distanceText: json['distanceText'],
        isLike: json['isLike'],
        imageCounts: json['imageCounts'],
        isCollected: json['isCollected'],
        collectCount: json['collectCount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleId'] = articleId;
    data['productType'] = productType;
    data['sourceType'] = sourceType;
    data['articleTitle'] = articleTitle;
    data['author'] = author.toJson();
    data['images'] = images.map((v) => v.toJson()).toList();
    data['hasVideo'] = hasVideo;
    data['readCount'] = readCount;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    data['urls'] = urls.map((v) => v.toJson()).toList();

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
    return data;
  }
}

class Author {
  int authorId;
  String nickName;
  String clientAuth;
  String jumpUrl;
  CoverImage coverImage;
  int identityType;
  String tag;

  Author(
      {required this.authorId,
      required this.nickName,
      required this.clientAuth,
      required this.jumpUrl,
      required this.coverImage,
      required this.identityType,
      required this.tag});

  factory Author.fromJson(Map<String, dynamic> json) {
    CoverImage coverImage = CoverImage.fromJson(json['coverImage']);
    return Author(
        authorId: json['authorId'],
        nickName: json['nickName'],
        clientAuth: json['clientAuth'],
        jumpUrl: json['jumpUrl'],
        coverImage: coverImage,
        identityType: json['identityType'],
        tag: json['tag']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorId'] = authorId;
    data['nickName'] = nickName;
    data['clientAuth'] = clientAuth;
    data['jumpUrl'] = jumpUrl;
    data['coverImage'] = coverImage.toJson();
    data['identityType'] = identityType;
    data['tag'] = tag;
    return data;
  }
}

class CoverImage {
  String dynamicUrl;
  String originalUrl;

  CoverImage({required this.dynamicUrl, required this.originalUrl});

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
        dynamicUrl: json['dynamicUrl'], originalUrl: json['originalUrl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    return data;
  }
}

class Images {
  int imageId;
  String dynamicUrl;
  String originalUrl;
  double width;
  double height;
  int mediaType;
  bool isWaterMarked;

  Images(
      {required this.imageId,
      required this.dynamicUrl,
      required this.originalUrl,
      required this.width,
      required this.height,
      required this.mediaType,
      required this.isWaterMarked});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        imageId: json['imageId'],
        dynamicUrl: json['dynamicUrl'],
        originalUrl: json['originalUrl'],
        width: json['width'],
        height: json['height'],
        mediaType: json['mediaType'],
        isWaterMarked: json['isWaterMarked']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String version;
  String appUrl;
  String h5Url;
  String wxUrl;

  Urls(
      {required this.version,
      required this.appUrl,
      required this.h5Url,
      required this.wxUrl});

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
        version: json['version'],
        appUrl: json['appUrl'],
        h5Url: json['h5Url'],
        wxUrl: json['wxUrl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['appUrl'] = appUrl;
    data['h5Url'] = h5Url;
    data['wxUrl'] = wxUrl;
    return data;
  }
}

class Pois {
  int poiType;
  int poiId;
  String poiName;
  int districtId;
  String districtName;
  String districtENName;
  PoiExt poiExt;
  int source;
  int isMain;

  Pois(
      {required this.poiType,
      required this.poiId,
      required this.poiName,
      required this.districtId,
      required this.districtName,
      required this.districtENName,
      required this.poiExt,
      required this.source,
      required this.isMain});

  factory Pois.fromJson(Map<String, dynamic> json) {
    PoiExt poiExt = PoiExt.fromJson(json['poiExt']);
    return Pois(
        poiType: json['poiType'],
        poiId: json['poiId'],
        poiName: json['poiName'],
        districtId: json['districtId'],
        districtName: json['districtName'],
        districtENName: json['districtENName'],
        poiExt: poiExt,
        source: json['source'],
        isMain: json['isMain']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poiType'] = poiType;
    data['poiId'] = poiId;
    data['poiName'] = poiName;
    data['districtId'] = districtId;
    data['districtName'] = districtName;
    data['districtENName'] = districtENName;
    data['poiExt'] = poiExt.toJson();
    data['source'] = source;
    data['isMain'] = isMain;
    return data;
  }
}

class PoiExt {
  String h5Url;
  String appUrl;

  PoiExt({required this.h5Url, required this.appUrl});

  factory PoiExt.fromJson(Map<String, dynamic> json) {
    return PoiExt(h5Url: json['h5Url'], appUrl: json['appUrl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h5Url'] = h5Url;
    data['appUrl'] = appUrl;
    return data;
  }
}
