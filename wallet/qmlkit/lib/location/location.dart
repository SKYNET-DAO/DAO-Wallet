class Location {
  Location({
    this.province,
    this.city,
    this.area,
    this.latitude,
    this.longitude,
    this.detailAddress,
    this.fullAddress,
    this.source,
    this.radius,
  });
  final double? latitude;
  final double? longitude;
  final String? province;
  final String? city;
  final String? area;
  final String? detailAddress;
  final String? fullAddress;
  //定位方式
  final String? source;
  //定位误差
  final double? radius;
  @override
  String toString() {
    return "latitude:$latitude,longitude:$longitude,province:$province,city:$city,area:$area,detailAddress:$detailAddress,fullAddress:$fullAddress,source:$source,radius:$radius";
  }

  static Location ins(Map info) {
    double latitude = info["latitude"]?.toDouble() ?? 0;
    double longitude = info["longitude"]?.toDouble() ?? 0;
    String province = info["province"];
    String city = info["city"];
    String area = info["area"];
    String detailAddress = info["detailAddress"];
    String fullAddress = info["fullAddress"];
    String source = info["source"];
    double radius = info["radius"]?.toDouble() ?? 0;
    return Location(
        latitude: latitude,
        longitude: longitude,
        province: province,
        city: city,
        area: area,
        detailAddress: detailAddress,
        fullAddress: fullAddress,
        source: source,
        radius: radius);
  }
}
