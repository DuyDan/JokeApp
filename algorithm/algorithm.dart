import 'dart:io';

  void main(List<String> args) {
  //Enter numbers from the keyboard
  print('Nhập 5 số nguyên dương cách nhau ');
  String arr = stdin.readLineSync() ?? '';

    RegExp nonDigitRegExp = RegExp(r'\D');
  if (nonDigitRegExp.hasMatch(arr.replaceAll(" ", ""))) {
    print('Bạn nhập chưa đúng yêu cầu');
  } else {
    //Split number sequence
    List<int> listInt = arr.split("").map(int.parse).toList();
    print(listInt);
    
    int min = listInt[0];
    int max = listInt[0];
    int sum = 0;
    int sumMin = 0;
    int sumMax = 0;

    if (listInt.length == 5) {
      for (var i = 0; i < listInt.length; i++) {
        //Find the smallest and largest number
        if(min > listInt[i]){
          min = listInt[i];
        };
        if(min < listInt[i]){
            max = listInt[i];
        };
        //Sum
        sum = sum + listInt[i];
      }
      //calculate minimum sum, maximum sum
      sumMax = sum - min;
      sumMin = sum - max;
      print('$sumMin, $sumMax');
    } else {
      print('Bạn nhập chưa đúng yêu cầu');
    }
  }

  
  
  
 
}