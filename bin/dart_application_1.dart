import 'dart:math';

import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'dart:io';

List<List<String>> massive = []; //поле

int whoWin = 0; //переменная для того, чтобы в конце понять кто выиграл

bool isKrestiki = true; //переменная для определения кто сейчас ходит

bool isGame = false; //переменная для игры (в цикле while крутится)

bool menu = true; //переменная для меню

Random random = Random();//рандом для опеределения кто ходит первым

bool isRobot = false; //переменная для определения против кого играть

class RobotClass{
  int column = 0;
  int row = 0;
}

///метод который проверяет заполнены ли все поля (если да и никто не выиграл -> ничья)
bool drawCheck(){ 
  int count = 0;
  for(int i = 0; i < massive.length; i++){
    for(int j = 0; j < massive.length; j++){
      if(massive[i][j] == "."){
        count++;
      }
    }
  }
  if(count == 0){
    return true;
  }else{
    return false;
  }
}

///функция для генерации рандомных чисел (ход робота)
RobotClass robotLogic(){
  RobotClass robot = RobotClass();
  bool validColumn = true;
  bool validRow = true;
  while(validColumn && validRow){
    robot.column = random.nextInt(massive.length);
    robot.row = random.nextInt(massive.length);
    if(massive[robot.column][robot.row] == "."){
      validColumn = false;
      validRow = false;
    }
  }
  
  return robot;
}

// ///функция для проверки победы
// bool checkWin(){ 
//   for (int i = 0; i < massive.length; i++){
//     for(int j = 0; j < massive.length - 2; j++){
//       //условие для проверки строк
//       if(massive[i][j] != "." && massive[i][j] == massive[i][j+1] && massive[i][j] == massive[i][j+2]){
//         whoWin = massive[i][j] == "X" ? 1 : 2;
//         return true;
//       }
//       //условие для проверки столбцов
//       if(massive[j][i] != "." && massive[j][i] == massive[j+1][i] && massive[j][i] == massive[j+2][i]){
//         whoWin = massive[j][i] == "X" ? 1 : 2;
//         return true;
//       }
//     }
//   }

// //проверяем диагональ слева направо
//   for(int i = 0; i < massive.length-2; i++){
//     for(int j = 0; j < massive.length-2; j++){
//       if(massive[i][j] != "." && massive[i][j] == massive[i+1][j+1] && massive[i][j] == massive[i+2][j+2]){
//         whoWin = massive[i][j] == "X" ? 1 : 2;
//         return true;
//       }
//     }
//   }

// //проверяем диагональ справа налево
//   for(int i = 0; i < massive.length - 2; i++){
//     for(int j = 2; j < massive.length; j++){
//       if(massive[i][j] != "." && massive[i][j] == massive[i+1][j-1] && massive[i][j] == massive[i+2][j-2]){
//         whoWin = massive[i][j] == "X" ? 1 : 2;
//         return true;
//       }
//     }
//   }

//   if(drawCheck()){
//     return true;
//   }



//   return false;
// }

bool checkWin() {
  // Проверяем строки
  for (int i = 0; i < massive.length; i++) {
    bool row = true;
    String firstChar = massive[i][0];
    if (firstChar != ".") { // Если первый символ не "." проверяем остальные
      for (int j = 1; j < massive[i].length; j++) {
        if (massive[i][j] != firstChar) {
          row = false;
          break;
        }
      }
      if (row) {
        whoWin = firstChar == "X" ? 1 : 2;
        return true;
      }
    }
  }

  // Проверяем столбцы
  for (int i = 0; i < massive.length; i++) {
    bool col = true;
    String firstChar = massive[0][i];
    if (firstChar != ".") { // Если первый символ не "." проверяем остальные
      for (int j = 1; j < massive.length; j++) {
        if (massive[j][i] != firstChar) {
          col = false;
          break;
        }
      }
      if (col) {
        whoWin = firstChar == "X" ? 1 : 2;
        return true;
      }
    }
  }

  // Проверяем диагонали слева направо
  bool diag1 = true;
  String Diag1 = massive[0][0];
  if (Diag1 != ".") { 
    for (int i = 1; i < massive.length; i++) {
      if (massive[i][i] != Diag1) {
        diag1 = false;
        break;
      }
    }
    if (diag1) {
      whoWin = Diag1 == "X" ? 1 : 2;
      return true;
    }
  }

  // Проверяем диагонали справа налево
  bool diag2 = true;
  String Diag2 = massive[0][massive.length - 1];
  if (Diag2 != ".") { 
    for (int i = 1; i < massive.length; i++) {
      if (massive[i][massive.length - 1 - i] != Diag2) {
        diag2 = false;
        break;
      }
    }
    if (diag2) {
      whoWin = Diag2 == "X" ? 1 : 2;
      return true;
    }
  }

  if (drawCheck()) {
    return true;
  }

  return false;
}





///функция для вывода красивого поля со значениями
void printPole(){ 
  var lenght = massive.length;
  String f = " ";

  for(int i = 1; i < lenght+1; i++){
    f = "$f $i";
  }

  for(int i = 0; i < lenght; i++){
    f = "$f\n${i+1} ";
    for(int j = 0; j < lenght; j++){
      f = "$f${massive[i][j]} ";
    }
  }

  print(f);
}

void game(){
  random.nextInt(2) == 0 ? isKrestiki = true : isKrestiki = false;
  whoWin = 0;
  isGame = !isGame;
  int i = 1;

    while(isGame){
      if(isRobot && i % 2 == 0){
        RobotClass robot = robotLogic();
        massive[robot.column][robot.row] = isKrestiki ? "X" : "O"; //проставляет робот
        isKrestiki = !isKrestiki;
        printPole();

      }else{
        print("Введите два числа:");
        String? input = stdin.readLineSync();

        var inputValues = input!.trim().split(' ');

        var numbers = inputValues.map((value) => int.parse(value)).toList();


        try{
          if(massive[numbers[0]-1][numbers[1]-1] == "."){
            massive[numbers[0]-1][numbers[1]-1] = isKrestiki ? "X" : "O"; //проставляет человек
            isKrestiki = !isKrestiki;
            printPole();
          }else{
            print("Нельзя поставить");
            i--; //нужно чтобы если были введены неверные значения робот стоял афк
          }
        }catch(e){
          print("Нельзя поставить");
          i--; //нужно чтобы если были введены неверные значения робот стоял афк
        } 
      }
      if(checkWin()){
          isGame = !isGame;
          switch(whoWin){
            case 0:
              print("Ничья");
              break;
            case 1:
              print("Победили крестики");
              break;
            case 2:
              print("Победили нолики");
              break;
          }
        }
      
      i++;
    }
    
  }

///функция для создания игрового поля по указанным пользователем параметрам
  void createPole(int count){
    for(int i = 0; i < count; i++){
      List<String> row = [];
      for(int j = 0; j < count; j++){
        row.add(".");
      }
      massive.add(row);
    }
    
    printPole();
  }

void main(List<String> arguments) {
  while(menu){
    //выбор режима
    print("1 - Игра друг с другом\n2 - Игра против робота");
  
    String? inputMode = stdin.readLineSync();

    var intInputMode = int.tryParse(inputMode!);

    if(intInputMode! > 0 && intInputMode <= 2){
      intInputMode == 1? isRobot = false : isRobot = true;
    }else{
      print("Введно неверно значение");
      continue;
    }

    //ввод параметров поля
    print("Введите число от 3 до 9");
    String? input = stdin.readLineSync();

    var intInput = int.tryParse(input!);

    if (intInput! <= 9 && intInput >= 3){
      massive.clear();
      createPole(intInput);
      game();
    }else{
      print("Введено неккоректное значение");
    }  
    //продолжаем игру или ливаем
    print("Чтобы ВЫЙТИ введите 0, чтобы остаться нажмите Enter");
    input =stdin.readLineSync();
    intInput = int.tryParse(input!);
    if(intInput == 0){
      return;
    }
  }
}
