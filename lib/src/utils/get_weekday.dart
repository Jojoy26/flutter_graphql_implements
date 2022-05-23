String getWeekday(int number) {
  switch(number){
    case 7:
      return "Dom";
    case 1:
      return "Seg";
    case 2:
      return "Ter";
    case 3:
      return "Qua";
    case 4:
      return "Qui";
    case 5:
      return "Sex";
    case 6:
      return "Sáb";
  }
  return "";
}