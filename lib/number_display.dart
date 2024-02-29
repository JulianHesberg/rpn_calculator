import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rpn_calculator/calculator_model.dart';

class NumberDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay> {
  final Calculator calculator = Calculator([]);
  String _inputController = "";
  num input = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RPM Calculator"),
      ),
      body: Column(children: [
        _buildStack(),
        _buildInputDisplay(),
        _buildInputs(),
        _buildStackOptions(),
      ]),
    );
  }

  Widget _buildStack() {
    return SizedBox(
        height: 100,
        child: Center(
          child: Wrap(
            children: [
              if(calculator.stack.length <10)
              for (final number in calculator.stack)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    number.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    key: const Key("Stack_Text"),
                  ),
                ),
              if(calculator.stack.length >= 10)
                for(int i = calculator.stack.length -10; i < calculator.stack.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      calculator.stack[i].toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 2,
                      key: const Key("Stack_Text"),
                    ),
                  ),
            ],
          ),
        ));
  }

  Widget _buildInputDisplay() {
    return SizedBox(
      height: 100,
      child: Center(
        child: Row(
          children: [
            Text(
              _inputController,
              style: Theme.of(context).textTheme.headlineLarge,
              key: const Key("Input_Text"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputs() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        // number of columns
        childAspectRatio: 1.3,
        // ratio of width to height
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 10,
        // vertical spacing
        crossAxisSpacing: 10,
        // horizontal spacing
        children: [
          buildButton('7'),
          buildButton('8'),
          buildButton('9'),
          buildButton('/'),
          buildButton('4'),
          buildButton('5'),
          buildButton('6'),
          buildButton('*'),
          buildButton('1'),
          buildButton('2'),
          buildButton('3'),
          buildButton('-'),
          buildButton('C'),
          buildButton('0'),
          buildButton('.'),
          buildButton('+'),
        ],
      ),
    );
  }

  Widget _buildStackOptions() {
    return Column(
      children: [
        buildButton('Add to Stack'),
        SizedBox(
          height: 20,
        ),
        buildButton('Clear Stack'),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  numberInput(num numInput) {
    setState(() {
      String currentValue = _inputController;
      String newValue = '$currentValue$numInput';
      _inputController = newValue;
      input = num.parse(newValue);
    });
  }

  doOperation(String operator) {
    setState(() {
      switch (operator) {
        case '+':
          calculator.execute(AddCommand());
          break;
        case '-':
          calculator.execute(SubtractCommand());
          break;
        case '*':
          calculator.execute(MultiplyCommand());
          break;
        case '/':
          calculator.execute(DivideCommand());
          break;
        default:
          print('Invalid operator');
          break;
      }
    });
  }

  addToStack() {
    setState(() {
      final num numInput = input;
      calculator.stack.add(numInput);
      clearInput();
    });
  }

  clearInput() {
    setState(() {
      _inputController = "";
      input = 0;
    });
  }

  clearStack() {
    setState(() {
      calculator.stack = [];
    });
  }

  addDecimalPoint() {
    String currentValue = _inputController;
    String newValue = '$currentValue.';
    _inputController = newValue;
    input = num.parse(newValue);
  }

  Widget buildButton(String label) {
    bool isNumber = false;
    try {
      final number = int.parse(label);
      isNumber = true;
    } catch (e) {
      isNumber = false;
    }
    if (isNumber) {
      return OutlinedButton(
        key: Key(label),
        onPressed: () => numberInput(int.parse(label)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: EdgeInsets.all(16),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    if (label == '+' || label == '-' || label == '/' || label == '*') {
      return OutlinedButton(
        key: Key(label),
        onPressed: () => doOperation(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          padding: EdgeInsets.all(16),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    if (label == 'Add to Stack') {
      return OutlinedButton(
        key: Key(label),
        onPressed: () => addToStack(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: EdgeInsets.all(16),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 25),
        ),
      );
    }
    if (label == '.') {
      return OutlinedButton(
        key: Key(label),
        onPressed: () => addDecimalPoint(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: EdgeInsets.all(16),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 30),
        ),
      );
    }

    if (label == 'Clear Stack') {
      return OutlinedButton(
        key: Key(label),
        onPressed: () => clearStack(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.all(16),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return OutlinedButton(
      key: Key(label),
      onPressed: () => clearInput(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(16),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
