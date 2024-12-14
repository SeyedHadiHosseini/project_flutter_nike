class BannerData {

final int id;
final String imageUrl;

BannerData.formJson(Map<String , dynamic>json)
: id = json['id'],
imageUrl = json['image'];

}