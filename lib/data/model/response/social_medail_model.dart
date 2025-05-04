class SocialMediaModel {
  List<SocialMediaModeLink>? data;

  SocialMediaModel({this.data});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SocialMediaModeLink>[];
      json['data'].forEach((v) {
        data!.add(new SocialMediaModeLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialMediaModeLink {
  int? id;
  String? image;
  String? url;

  SocialMediaModeLink({this.id, this.image, this.url});

  SocialMediaModeLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}
