// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rpn_calculator/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checks numbers pressed are displayed to user', (WidgetTester tester) async {
    //build app, trigger frame
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('1234');
    expect(find.displayText(), '1234');
  });


  testWidgets('Add 2 and 2 together', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('2');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('2'));

    await tester.enterDigits('2');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('2, 2'));

    await tester.tapAddCommand();
    expect(find.stackText(), equals('4'));
  });

  testWidgets('Subtract 2 from 3', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('2');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('2'));

    await tester.enterDigits('3');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('2, 3'));

    await tester.tapSubtractCommand();
    expect(find.stackText(), equals('1'));
  });

  testWidgets('Divide 10 by 5', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('5');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('5'));

    await tester.enterDigits('10');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('5, 10'));

    await tester.tapDivideCommand();
    expect(find.stackText(), equals('2.0'));
  });

  testWidgets('Multiply 4 by 9', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('4');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('4'));

    await tester.enterDigits('9');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('4, 9'));

    await tester.tapMultiplyCommand();
    expect(find.stackText(), equals('36'));
  });

  testWidgets('Clear stack with values', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('2');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('2'));

    await tester.enterDigits('3');
    await tester.tapAddToStack();
    expect(find.stackText(), equals('2, 3'));

    await tester.tapClearStack();
    expect(find.stackText(), equals(''));
  });

  testWidgets('Clear Input', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));
    await tester.enterDigits('2345');
    expect(find.displayText(), equals('2345'));


    await tester.tapClearDisplay();
    expect(find.stackText(), equals(''));
  });

  testWidgets('More than 10 in stack displays correct', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());

    expect(find.displayText(), equals(''));

    final numbers = [1,2,3,4,5,6,7,8,9,10,11];
    for(int number in numbers){
      await tester.enterDigits(number.toString());
      await tester.tapAddToStack();
    }

    expect(find.stackText(), "2, 3, 4, 5, 6, 7, 8, 9, 10, 11");
  });


}
extension TesterExtensions on WidgetTester{

  Future<void> enterDigits(String digits) async{
    for (var digit in digits.characters){
      await tapByKey(Key(digit));
    }
  }

  Future<void> tapByKey(Key key) async{
    await tap(find.byKey(key));
    await pump();
  }
  
  Future<void> tapAddToStack() async{
    await tap(find.byKey(const Key('Add to Stack')));
    await pump();
  }

  Future<void> tapClearStack() async{
    await tap(find.byKey(const Key('Clear Stack')));
    await pump();
  }

  Future<void> tapClearDisplay() async{
    await tap(find.byKey(Key('C')));
    await pump();
  }

  Future<void> tapAddCommand() async{
    await tap(find.byKey(const Key('+')));
    await pump();
  }

  Future<void> tapSubtractCommand() async{
    await tap(find.byKey(const Key('-')));
    await pump();
  }

  Future<void> tapMultiplyCommand() async{
    await tap(find.byKey(const Key('*')));
    await pump();
  }

  Future<void> tapDivideCommand() async{
    await tap(find.byKey(const Key('/')));
    await pump();
  }
}

extension FinderExtensions on CommonFinders{
  String? displayText(){
    final text = byKey(Key("Input_Text")).evaluate().single.widget as Text;
    return text.data;
  }

  String? stackText(){
    final text = byKey(Key('Stack_Text')).evaluate().single.widget as Text;
    return text.data;
  }
}
