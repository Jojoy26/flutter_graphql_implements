class CardTypeModel {
  final String label;
  final String image;
  CardTypeModel({
    required this.label,
    required this.image,
  });
}

List<CardTypeModel> listCardTypeModel = [
  CardTypeModel(
    label: "Ranqueada", 
    image: "ranked.svg"
  ),
  CardTypeModel(
    label: "Duelo 1x1", 
    image: "duel.svg"
  ),
  CardTypeModel(
    label: "Diversão", 
    image: "fun.svg"
  )
];