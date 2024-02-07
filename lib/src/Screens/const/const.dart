import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the list of vegetables
final vegetablesProvider = Provider<List<Vegetable>>((ref) {
  return vegetables;
});

// Provider for the selected vegetable
final selectedVegetableProvider = StateProvider<Vegetable?>((ref) {
  // Use ref.watch to get the current value of vegetablesProvider
  final vegetables = ref.watch(vegetablesProvider);
  
  // You can customize this logic based on your app's requirements
  if (vegetables.isNotEmpty) {
    return vegetables[0]; // Set the selected vegetable to the first one by default
  } else {
    return null;
  }
});

class VegetableDetail {
  String title;
  String? title1;
  String iconPath;
  String shortSpec;
  String description;

  VegetableDetail({
    required this.title,
    required this.iconPath,
    required this.shortSpec,
    required this.description,
  });
}

class Vegetable {
  int id;
  String image;
  String appBarImage;
  String name;
  List<VegetableDetail> info;
  bool jandec;
  int spS;
  int spE;
  int bpS;
  int bpE;
  int hpS;
  int hpE;

  Vegetable({
    required this.appBarImage,
    required this.id,
    required this.image,
    required this.info,
    required this.name,
    required this.bpS,
    required this.bpE,
    required this.hpE,
    required this.hpS,
    required this.jandec,
    required this.spE,
    required this.spS,
  });

}

class Images{
static const depth ="assets/depth.svg";
static const bean ="assets/bean.svg";
static const pot ="assets/pot.svg";
static const fertilizer ="assets/fertilizer.svg";
static const duration ="assets/duration.svg";
static const season ="assets/season.svg";
static const spacing ="assets/spacing.svg";
static const spacing1 ="assets/spacing(1).svg";
static const watering ="assets/watering.svg";
static const tomato ="assets/tomato.jpg";
static const tomato1 ="assets/tomato1.jpg";
static const capsicum ="assets/capsicum.jpeg";
static const capsicum1 ="assets/capsicum1.jpeg";
static const cauliflower ="assets/cauliflower.jpg";
static const cauliflower1 ="assets/cauliflower1.jpg";
static const brinjal ="assets/brinjal.jpg";
}





final List<Vegetable> vegetables = [
  Vegetable( id: 1,appBarImage: Images.tomato, image: Images.tomato1, info: vegetableDetails, name: "Tomato",spE: 6, spS: 2, bpS: 3, bpE: 9, hpE: 5, hpS: 10, jandec: true),
  Vegetable( id: 2,appBarImage: Images.cauliflower, image: Images.cauliflower1, info: vegetableDetails, name: "Cauliflower",spE: 6, spS: 2, bpS: 3, bpE: 9, hpE: 5, hpS: 10, jandec: true),
  Vegetable( id: 3,appBarImage: Images.capsicum, image: Images.capsicum1, info: vegetableDetails, name: "Capsicum",spE: 6, spS: 2, bpS: 3, bpE: 9, hpE: 5, hpS: 10, jandec: true),
  Vegetable( id: 5,appBarImage: Images.brinjal, image: Images.brinjal, info: vegetableDetails, name: "Brinjal",spE: 6, spS: 2, bpS: 3, bpE: 9, hpE: 5, hpS: 10, jandec: true),
 ];



final List<VegetableDetail> vegetableDetails = [
    VegetableDetail(
      title: 'Depth',
      iconPath: Images.depth,
      shortSpec: '1 cm',
      description: 'Detailed information about planting depth.',
    ),
    VegetableDetail(
      title: 'Spacing',
      iconPath: Images.spacing,
      shortSpec: '45 cm',
      description: 'Detailed information about plant spacing.',
    ), 
    VegetableDetail(
      title: 'Spacing',
      iconPath: Images.spacing1,
      shortSpec: '60 cm',
      description: 'Detailed information about plant spacing.',
    ),
    VegetableDetail(
      title: 'Crop duration',
      iconPath: Images.duration,
      shortSpec: '120 days',
      description: 'Detailed information about plant spacing.',
    ),
    VegetableDetail(
      title: 'Watering',
      iconPath: Images.watering,
      shortSpec: 'Once a week',
      description: 'Detailed information about planting depth.',
    ),
    VegetableDetail(
      title: 'Season:',
      iconPath: Images.season,
      shortSpec: 'Warm',
      description: 'Detailed information about plant spacing.',
    ),
    VegetableDetail(
      title: 'Germination',
      iconPath: Images.bean,
      shortSpec: '7-10  days',
      description: 'Detailed information about plant spacing.',
    ),
    VegetableDetail(
      title: 'Sowing type',
      iconPath: Images.bean,
      shortSpec: 'Transplant',
      description: 'Detailed information about planting depth.',
    ),
    VegetableDetail(
      title: 'Fertilizer:',
      iconPath: Images.fertilizer,
      shortSpec: '10 cm',
      description: 'Detailed information about plant spacing.',
    ),
    VegetableDetail(
      title: 'Pot',
      iconPath: Images.pot,
      shortSpec: '10 cm',
      description: 'Detailed information about plant spacing.',
    ),
    
  ];
