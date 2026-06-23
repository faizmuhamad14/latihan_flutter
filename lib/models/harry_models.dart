// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'harry_models.g.dart';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Welcome {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "alternate_names")
  List<String> alternateNames;
  @JsonKey(name: "species")
  String species;
  @JsonKey(name: "gender")
  Gender gender;
  @JsonKey(name: "house")
  House house;
  @JsonKey(name: "dateOfBirth")
  String? dateOfBirth;
  @JsonKey(name: "yearOfBirth")
  int? yearOfBirth;
  @JsonKey(name: "wizard")
  bool wizard;
  @JsonKey(name: "ancestry")
  Ancestry ancestry;
  @JsonKey(name: "eyeColour")
  EyeColour eyeColour;
  @JsonKey(name: "hairColour")
  HairColour hairColour;
  @JsonKey(name: "wand")
  Wand wand;
  @JsonKey(name: "patronus")
  Patronus patronus;
  @JsonKey(name: "hogwartsStudent")
  bool hogwartsStudent;
  @JsonKey(name: "hogwartsStaff")
  bool hogwartsStaff;
  @JsonKey(name: "actor")
  String actor;
  @JsonKey(name: "alternate_actors")
  List<String> alternateActors;
  @JsonKey(name: "alive")
  bool alive;
  @JsonKey(name: "image")
  String image;

  Welcome({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) =>
      _$WelcomeFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomeToJson(this);
}

enum Ancestry {
  @JsonValue("")
  EMPTY,
  @JsonValue("half-blood")
  HALF_BLOOD,
  @JsonValue("half-veela")
  HALF_VEELA,
  @JsonValue("muggle")
  MUGGLE,
  @JsonValue("muggleborn")
  MUGGLEBORN,
  @JsonValue("pure-blood")
  PURE_BLOOD,
  @JsonValue("quarter-veela")
  QUARTER_VEELA,
  @JsonValue("squib")
  SQUIB,
}

final ancestryValues = EnumValues({
  "": Ancestry.EMPTY,
  "half-blood": Ancestry.HALF_BLOOD,
  "half-veela": Ancestry.HALF_VEELA,
  "muggle": Ancestry.MUGGLE,
  "muggleborn": Ancestry.MUGGLEBORN,
  "pure-blood": Ancestry.PURE_BLOOD,
  "quarter-veela": Ancestry.QUARTER_VEELA,
  "squib": Ancestry.SQUIB,
});

enum EyeColour {
  @JsonValue("amber")
  AMBER,
  @JsonValue("beady")
  BEADY,
  @JsonValue("black")
  BLACK,
  @JsonValue("blue")
  BLUE,
  @JsonValue("brown")
  BROWN,
  @JsonValue("dark")
  DARK,
  @JsonValue("")
  EMPTY,
  @JsonValue("green")
  GREEN,
  @JsonValue("grey")
  GREY,
  @JsonValue("hazel")
  HAZEL,
  @JsonValue("orange")
  ORANGE,
  @JsonValue("pale, silvery")
  PALE_SILVERY,
  @JsonValue("Scarlet")
  SCARLET,
  @JsonValue("silver")
  SILVER,
  @JsonValue("white")
  WHITE,
  @JsonValue("yellow")
  YELLOW,
  @JsonValue("yellowish")
  YELLOWISH,
}

final eyeColourValues = EnumValues({
  "amber": EyeColour.AMBER,
  "beady": EyeColour.BEADY,
  "black": EyeColour.BLACK,
  "blue": EyeColour.BLUE,
  "brown": EyeColour.BROWN,
  "dark": EyeColour.DARK,
  "": EyeColour.EMPTY,
  "green": EyeColour.GREEN,
  "grey": EyeColour.GREY,
  "hazel": EyeColour.HAZEL,
  "orange": EyeColour.ORANGE,
  "pale, silvery": EyeColour.PALE_SILVERY,
  "Scarlet": EyeColour.SCARLET,
  "silver": EyeColour.SILVER,
  "white": EyeColour.WHITE,
  "yellow": EyeColour.YELLOW,
  "yellowish": EyeColour.YELLOWISH,
});

enum Gender {
  @JsonValue("")
  EMPTY,
  @JsonValue("female")
  FEMALE,
  @JsonValue("male")
  MALE,
}

final genderValues = EnumValues({
  "": Gender.EMPTY,
  "female": Gender.FEMALE,
  "male": Gender.MALE,
});

enum HairColour {
  @JsonValue("bald")
  BALD,
  @JsonValue("black")
  BLACK,
  @JsonValue("blond")
  BLOND,
  @JsonValue("blonde")
  BLONDE,
  @JsonValue("brown")
  BROWN,
  @JsonValue("dark")
  DARK,
  @JsonValue("dull")
  DULL,
  @JsonValue("")
  EMPTY,
  @JsonValue("ginger")
  GINGER,
  @JsonValue("green")
  GREEN,
  @JsonValue("grey")
  GREY,
  @JsonValue("purple")
  PURPLE,
  @JsonValue("red")
  RED,
  @JsonValue("sandy")
  SANDY,
  @JsonValue("silver")
  SILVER,
  @JsonValue("tawny")
  TAWNY,
  @JsonValue("white")
  WHITE,
}

final hairColourValues = EnumValues({
  "bald": HairColour.BALD,
  "black": HairColour.BLACK,
  "blond": HairColour.BLOND,
  "blonde": HairColour.BLONDE,
  "brown": HairColour.BROWN,
  "dark": HairColour.DARK,
  "dull": HairColour.DULL,
  "": HairColour.EMPTY,
  "ginger": HairColour.GINGER,
  "green": HairColour.GREEN,
  "grey": HairColour.GREY,
  "purple": HairColour.PURPLE,
  "red": HairColour.RED,
  "sandy": HairColour.SANDY,
  "silver": HairColour.SILVER,
  "tawny": HairColour.TAWNY,
  "white": HairColour.WHITE,
});

enum House {
  @JsonValue("")
  EMPTY,
  @JsonValue("Gryffindor")
  GRYFFINDOR,
  @JsonValue("Hufflepuff")
  HUFFLEPUFF,
  @JsonValue("Ravenclaw")
  RAVENCLAW,
  @JsonValue("Slytherin")
  SLYTHERIN,
}

final houseValues = EnumValues({
  "": House.EMPTY,
  "Gryffindor": House.GRYFFINDOR,
  "Hufflepuff": House.HUFFLEPUFF,
  "Ravenclaw": House.RAVENCLAW,
  "Slytherin": House.SLYTHERIN,
});

enum Patronus {
  @JsonValue("boar")
  BOAR,
  @JsonValue("doe")
  DOE,
  @JsonValue("")
  EMPTY,
  @JsonValue("goat")
  GOAT,
  @JsonValue("hare")
  HARE,
  @JsonValue("horse")
  HORSE,
  @JsonValue("Jack Russell terrier")
  JACK_RUSSELL_TERRIER,
  @JsonValue("lynx")
  LYNX,
  @JsonValue("Non-Corporeal")
  NON_CORPOREAL,
  @JsonValue("otter")
  OTTER,
  @JsonValue("persian cat")
  PERSIAN_CAT,
  @JsonValue("Phoenix")
  PHOENIX,
  @JsonValue("stag")
  STAG,
  @JsonValue("swan")
  SWAN,
  @JsonValue("tabby cat")
  TABBY_CAT,
  @JsonValue("weasel")
  WEASEL,
  @JsonValue("wolf")
  WOLF,
}

final patronusValues = EnumValues({
  "boar": Patronus.BOAR,
  "doe": Patronus.DOE,
  "": Patronus.EMPTY,
  "goat": Patronus.GOAT,
  "hare": Patronus.HARE,
  "horse": Patronus.HORSE,
  "Jack Russell terrier": Patronus.JACK_RUSSELL_TERRIER,
  "lynx": Patronus.LYNX,
  "Non-Corporeal": Patronus.NON_CORPOREAL,
  "otter": Patronus.OTTER,
  "persian cat": Patronus.PERSIAN_CAT,
  "Phoenix": Patronus.PHOENIX,
  "stag": Patronus.STAG,
  "swan": Patronus.SWAN,
  "tabby cat": Patronus.TABBY_CAT,
  "weasel": Patronus.WEASEL,
  "wolf": Patronus.WOLF,
});

@JsonSerializable()
class Wand {
  @JsonKey(name: "wood")
  String wood;
  @JsonKey(name: "core")
  Core core;
  @JsonKey(name: "length")
  double? length;

  Wand({required this.wood, required this.core, required this.length});

  factory Wand.fromJson(Map<String, dynamic> json) => _$WandFromJson(json);

  Map<String, dynamic> toJson() => _$WandToJson(this);
}

enum Core {
  @JsonValue("dragon heartstring")
  DRAGON_HEARTSTRING,
  @JsonValue("")
  EMPTY,
  @JsonValue("phoenix feather")
  PHOENIX_FEATHER,
  @JsonValue("phoenix tail feather")
  PHOENIX_TAIL_FEATHER,
  @JsonValue("unicorn hair")
  UNICORN_HAIR,
  @JsonValue("unicorn tail hair")
  UNICORN_TAIL_HAIR,
}

final coreValues = EnumValues({
  "dragon heartstring": Core.DRAGON_HEARTSTRING,
  "": Core.EMPTY,
  "phoenix feather": Core.PHOENIX_FEATHER,
  "phoenix tail feather": Core.PHOENIX_TAIL_FEATHER,
  "unicorn hair": Core.UNICORN_HAIR,
  "unicorn tail hair": Core.UNICORN_TAIL_HAIR,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
