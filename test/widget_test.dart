// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/calculator_model.dart';

import 'package:rpn_calculator/main.dart';

void main() {
  test('AddCommand', (){
    final List<num> stack = [1,2,3,4,5];
    AddCommand().apply(stack);
    expect(stack, [1,2,3,9]);
  });

  test('SubtractCommand', (){
    final List<num> stack = [1,2,3,4,5];
    SubtractCommand().apply(stack);
    expect(stack, [1,2,3,1]);
  });

  test('MultiplyCommand', (){
    final List<num> stack = [1,2,3,4,5];
    MultiplyCommand().apply(stack);
    expect(stack, [1,2,3,20]);
  });

  test('DivideCommand', (){
    final List<num> stack = [1,2,3,5,5];
    DivideCommand().apply(stack);
    expect(stack, [1,2,3,1]);
  });
}
