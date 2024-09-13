class GetProductsModel {
  int? id;
  int? category;
  String? categoryName;
  int? shape;
  String? shapeName;
  int? material;
  String? materialName;
  int? rating;
  int? ratingValue;
  int? price;
  int? minimumQuantity;
  String? name;
  int? size;
  String? weight;
  int? discountPrice;
  Description? description;
  double? discountPercent;
  List<Images>? images;

  GetProductsModel(
      {this.id,
        this.category,
        this.categoryName,
        this.shape,
        this.shapeName,
        this.material,
        this.materialName,
        this.rating,
        this.ratingValue,
        this.price,
        this.minimumQuantity,
        this.name,
        this.size,
        this.weight,
        this.discountPrice,
        this.description,
        this.discountPercent,
        this.images});

  GetProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    categoryName = json['category_name'];
    shape = json['shape'];
    shapeName = json['shape_name'];
    material = json['material'];
    materialName = json['material_name'];
    rating = json['rating'];
    ratingValue = json['rating_value'];
    price = json['price'];
    minimumQuantity = json['minimum_quantity'];
    name = json['name'];
    size = json['size'];
    weight = json['weight'];
    discountPrice = json['discount_price'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    discountPercent = json['discount_percent'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['category_name'] = categoryName;
    data['shape'] = shape;
    data['shape_name'] = shapeName;
    data['material'] = material;
    data['material_name'] = materialName;
    data['rating'] = rating;
    data['rating_value'] = ratingValue;
    data['price'] = price;
    data['minimum_quantity'] = minimumQuantity;
    data['name'] = name;
    data['size'] = size;
    data['weight'] = weight;
    data['discount_price'] = discountPrice;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['discount_percent'] = discountPercent;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Description {
  String? note;
  String? suitableFor;
  String? dispatchTime;
  String? careInstructions;

  Description(
      {this.note, this.suitableFor, this.dispatchTime, this.careInstructions});

  Description.fromJson(Map<String, dynamic> json) {
    note = json['Note'];
    suitableFor = json['Suitable for'];
    dispatchTime = json['Dispatch time'];
    careInstructions = json['Care Instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Note'] = note;
    data['Suitable for'] = suitableFor;
    data['Dispatch time'] = dispatchTime;
    data['Care Instructions'] = careInstructions;
    return data;
  }
}

class Images {
  int? id;
  String? image;

  Images({this.id, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
