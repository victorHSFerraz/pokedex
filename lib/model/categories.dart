class Categories {
  String films;
  String people;
  String planets;
  String species;
  String starships;
  String vehicles;

  Categories(
      {this.films,
      this.people,
      this.planets,
      this.species,
      this.starships,
      this.vehicles});

  Categories.fromJson(Map<String, dynamic> json) {
    films = json['films'];
    people = json['people'];
    planets = json['planets'];
    species = json['species'];
    starships = json['starships'];
    vehicles = json['vehicles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['films'] = this.films;
    data['people'] = this.people;
    data['planets'] = this.planets;
    data['species'] = this.species;
    data['starships'] = this.starships;
    data['vehicles'] = this.vehicles;
    return data;
  }
}
