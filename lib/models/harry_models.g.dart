// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harry_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Welcome _$WelcomeFromJson(Map<String, dynamic> json) => Welcome(
  id: json['id'] as String,
  name: json['name'] as String,
  alternateNames: (json['alternate_names'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  species: json['species'] as String,
  gender: $enumDecode(_$GenderEnumMap, json['gender']),
  house: $enumDecode(_$HouseEnumMap, json['house']),
  dateOfBirth: json['dateOfBirth'] as String?,
  yearOfBirth: (json['yearOfBirth'] as num?)?.toInt(),
  wizard: json['wizard'] as bool,
  ancestry: $enumDecode(_$AncestryEnumMap, json['ancestry']),
  eyeColour: $enumDecode(_$EyeColourEnumMap, json['eyeColour']),
  hairColour: $enumDecode(_$HairColourEnumMap, json['hairColour']),
  wand: Wand.fromJson(json['wand'] as Map<String, dynamic>),
  patronus: $enumDecode(_$PatronusEnumMap, json['patronus']),
  hogwartsStudent: json['hogwartsStudent'] as bool,
  hogwartsStaff: json['hogwartsStaff'] as bool,
  actor: json['actor'] as String,
  alternateActors: (json['alternate_actors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  alive: json['alive'] as bool,
  image: json['image'] as String,
);

Map<String, dynamic> _$WelcomeToJson(Welcome instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'alternate_names': instance.alternateNames,
  'species': instance.species,
  'gender': _$GenderEnumMap[instance.gender]!,
  'house': _$HouseEnumMap[instance.house]!,
  'dateOfBirth': instance.dateOfBirth,
  'yearOfBirth': instance.yearOfBirth,
  'wizard': instance.wizard,
  'ancestry': _$AncestryEnumMap[instance.ancestry]!,
  'eyeColour': _$EyeColourEnumMap[instance.eyeColour]!,
  'hairColour': _$HairColourEnumMap[instance.hairColour]!,
  'wand': instance.wand,
  'patronus': _$PatronusEnumMap[instance.patronus]!,
  'hogwartsStudent': instance.hogwartsStudent,
  'hogwartsStaff': instance.hogwartsStaff,
  'actor': instance.actor,
  'alternate_actors': instance.alternateActors,
  'alive': instance.alive,
  'image': instance.image,
};

const _$GenderEnumMap = {
  Gender.EMPTY: '',
  Gender.FEMALE: 'female',
  Gender.MALE: 'male',
};

const _$HouseEnumMap = {
  House.EMPTY: '',
  House.GRYFFINDOR: 'Gryffindor',
  House.HUFFLEPUFF: 'Hufflepuff',
  House.RAVENCLAW: 'Ravenclaw',
  House.SLYTHERIN: 'Slytherin',
};

const _$AncestryEnumMap = {
  Ancestry.EMPTY: '',
  Ancestry.HALF_BLOOD: 'half-blood',
  Ancestry.HALF_VEELA: 'half-veela',
  Ancestry.MUGGLE: 'muggle',
  Ancestry.MUGGLEBORN: 'muggleborn',
  Ancestry.PURE_BLOOD: 'pure-blood',
  Ancestry.QUARTER_VEELA: 'quarter-veela',
  Ancestry.SQUIB: 'squib',
};

const _$EyeColourEnumMap = {
  EyeColour.AMBER: 'amber',
  EyeColour.BEADY: 'beady',
  EyeColour.BLACK: 'black',
  EyeColour.BLUE: 'blue',
  EyeColour.BROWN: 'brown',
  EyeColour.DARK: 'dark',
  EyeColour.EMPTY: '',
  EyeColour.GREEN: 'green',
  EyeColour.GREY: 'grey',
  EyeColour.HAZEL: 'hazel',
  EyeColour.ORANGE: 'orange',
  EyeColour.PALE_SILVERY: 'pale, silvery',
  EyeColour.SCARLET: 'Scarlet',
  EyeColour.SILVER: 'silver',
  EyeColour.WHITE: 'white',
  EyeColour.YELLOW: 'yellow',
  EyeColour.YELLOWISH: 'yellowish',
};

const _$HairColourEnumMap = {
  HairColour.BALD: 'bald',
  HairColour.BLACK: 'black',
  HairColour.BLOND: 'blond',
  HairColour.BLONDE: 'blonde',
  HairColour.BROWN: 'brown',
  HairColour.DARK: 'dark',
  HairColour.DULL: 'dull',
  HairColour.EMPTY: '',
  HairColour.GINGER: 'ginger',
  HairColour.GREEN: 'green',
  HairColour.GREY: 'grey',
  HairColour.PURPLE: 'purple',
  HairColour.RED: 'red',
  HairColour.SANDY: 'sandy',
  HairColour.SILVER: 'silver',
  HairColour.TAWNY: 'tawny',
  HairColour.WHITE: 'white',
};

const _$PatronusEnumMap = {
  Patronus.BOAR: 'boar',
  Patronus.DOE: 'doe',
  Patronus.EMPTY: '',
  Patronus.GOAT: 'goat',
  Patronus.HARE: 'hare',
  Patronus.HORSE: 'horse',
  Patronus.JACK_RUSSELL_TERRIER: 'Jack Russell terrier',
  Patronus.LYNX: 'lynx',
  Patronus.NON_CORPOREAL: 'Non-Corporeal',
  Patronus.OTTER: 'otter',
  Patronus.PERSIAN_CAT: 'persian cat',
  Patronus.PHOENIX: 'Phoenix',
  Patronus.STAG: 'stag',
  Patronus.SWAN: 'swan',
  Patronus.TABBY_CAT: 'tabby cat',
  Patronus.WEASEL: 'weasel',
  Patronus.WOLF: 'wolf',
};

Wand _$WandFromJson(Map<String, dynamic> json) => Wand(
  wood: json['wood'] as String,
  core: $enumDecode(_$CoreEnumMap, json['core']),
  length: (json['length'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WandToJson(Wand instance) => <String, dynamic>{
  'wood': instance.wood,
  'core': _$CoreEnumMap[instance.core]!,
  'length': instance.length,
};

const _$CoreEnumMap = {
  Core.DRAGON_HEARTSTRING: 'dragon heartstring',
  Core.EMPTY: '',
  Core.PHOENIX_FEATHER: 'phoenix feather',
  Core.PHOENIX_TAIL_FEATHER: 'phoenix tail feather',
  Core.UNICORN_HAIR: 'unicorn hair',
  Core.UNICORN_TAIL_HAIR: 'unicorn tail hair',
};
