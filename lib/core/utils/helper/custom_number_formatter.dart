import 'package:flutter/services.dart';

class CustomNumberFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    String value = newValue.text.replaceAll(" ", "");

    String formattedValue = "";
    for(int i =0 ; i< value.length; i++){
      if(i%4 == 0 && i!=0){
        formattedValue += " ";
      }
      formattedValue += value[i];
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

}