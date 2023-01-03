class Category {
  List<CategoryList>? categoryList;
  String? status;

  Category({this.categoryList, this.status});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class CategoryList {
  String? categoryId;
  String? categoryName;
  String? imageName;

  CategoryList({this.categoryId, this.categoryName, this.imageName});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    imageName = json['image_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['image_name'] = this.imageName;
    return data;
  }
}
