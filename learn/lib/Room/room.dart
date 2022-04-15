class Room {
  int id;
  String description;
  int price;
  bool isAc;
  List<String> imageUrls = [];
  Room(this.id, this.description, this.price, this.isAc);

  void setImageUrls(List<String> urls) {
    imageUrls = urls;
  }

  void setFromMap(Map<dynamic, dynamic> mp) {
    id = mp["id"];
    description = mp["description"];
    price = mp["price"];
    isAc = mp["isAC"];
    List<String> temp = [];
    var storedUrls = mp["imageUrls"];
    if (storedUrls != null) {
      for (var url in storedUrls) {
        temp.add(url as String);
      }
    }
    imageUrls = temp;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'price': price,
      'isAC': isAc,
      'imageUrls': imageUrls
    };
  }
}
