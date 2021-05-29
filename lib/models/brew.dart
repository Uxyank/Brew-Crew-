class Brew {
  final String name;
  final String sugars;
  final int strength;
  Brew({required this.name, required this.sugars, required this.strength});
}
//  Brew.fromJson(Map<String, Object?> json)
//       : this(
//           name: json['name']! as String,
//           sugars: json['sugars']! as String,
//           strength: json['strength']! as int,
//         );

//   Map<String, Object?> toJson() {
//     return {
//       'name': name,
//       'sugars': sugars,
//       'strength': strength,
//     };
//   }
