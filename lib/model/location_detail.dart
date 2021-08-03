class LocationDetail {
  int id;
  String name;
  int gameIndex;
  List<EncounterMethodRates> encounterMethodRates;
  EncounterMethod location;
  List<Names> names;
  List<PokemonEncounters> pokemonEncounters;

  LocationDetail(
      {this.id,
      this.name,
      this.gameIndex,
      this.encounterMethodRates,
      this.location,
      this.names,
      this.pokemonEncounters});

  LocationDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gameIndex = json['game_index'];
    if (json['encounter_method_rates'] != null) {
      encounterMethodRates = new List<EncounterMethodRates>();
      json['encounter_method_rates'].forEach((v) {
        encounterMethodRates.add(new EncounterMethodRates.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new EncounterMethod.fromJson(json['location'])
        : null;
    if (json['names'] != null) {
      names = new List<Names>();
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    if (json['pokemon_encounters'] != null) {
      pokemonEncounters = new List<PokemonEncounters>();
      json['pokemon_encounters'].forEach((v) {
        pokemonEncounters.add(new PokemonEncounters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['game_index'] = this.gameIndex;
    if (this.encounterMethodRates != null) {
      data['encounter_method_rates'] =
          this.encounterMethodRates.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.pokemonEncounters != null) {
      data['pokemon_encounters'] =
          this.pokemonEncounters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EncounterMethodRates {
  EncounterMethod encounterMethod;
  List<VersionDetails> versionDetails;

  EncounterMethodRates({this.encounterMethod, this.versionDetails});

  EncounterMethodRates.fromJson(Map<String, dynamic> json) {
    encounterMethod = json['encounter_method'] != null
        ? new EncounterMethod.fromJson(json['encounter_method'])
        : null;
    if (json['version_details'] != null) {
      versionDetails = new List<VersionDetails>();
      json['version_details'].forEach((v) {
        versionDetails.add(new VersionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.encounterMethod != null) {
      data['encounter_method'] = this.encounterMethod.toJson();
    }
    if (this.versionDetails != null) {
      data['version_details'] =
          this.versionDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EncounterMethod {
  String name;
  String url;

  EncounterMethod({this.name, this.url});

  EncounterMethod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class VersionDetails {
  int rate;
  EncounterMethod version;

  VersionDetails({this.rate, this.version});

  VersionDetails.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    version = json['version'] != null
        ? new EncounterMethod.fromJson(json['version'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    if (this.version != null) {
      data['version'] = this.version.toJson();
    }
    return data;
  }
}

class Names {
  String name;
  EncounterMethod language;

  Names({this.name, this.language});

  Names.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'] != null
        ? new EncounterMethod.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class PokemonEncounters {
  EncounterMethod pokemon;
  List<VersionDetails> versionDetails;

  PokemonEncounters({this.pokemon, this.versionDetails});

  PokemonEncounters.fromJson(Map<String, dynamic> json) {
    pokemon = json['pokemon'] != null
        ? new EncounterMethod.fromJson(json['pokemon'])
        : null;
    if (json['version_details'] != null) {
      versionDetails = new List<VersionDetails>();
      json['version_details'].forEach((v) {
        versionDetails.add(new VersionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.toJson();
    }
    if (this.versionDetails != null) {
      data['version_details'] =
          this.versionDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
