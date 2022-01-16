class FilterObject {
  String? brand = '%20';
  String? category = '%20';
  String? make = '%20';
  String? name = '%20';
  String? model = '%20';
  String? gender = '%20';
  String? minPrice = '%20';
  String? maxPrice = '%20';
  bool used = false;

  FilterObject.name(this.brand, this.category, this.make, this.name, this.model,
      this.gender, this.minPrice, this.maxPrice);

  FilterObject.category(this.category);

  FilterObject.brand(this.category, this.brand);

  FilterObject();
}