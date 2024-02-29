
abstract class Command{
  void apply(List<num> stack);
}

typedef Operator = num Function(num a, num b);

applyOperator(List<num> stack, Operator operator){
  if(stack.length<2){
    throw Exception("stack is less then lenth 2");
  }

  var right = stack.removeLast();
  var left = stack.removeLast();

  num result = operator(right, left);
  stack.add(result);

}

class AddCommand implements Command{
  void apply(List<num> stack){
    applyOperator(stack, (a, b) => a + b);
  }
}

class SubtractCommand implements Command{
  void apply(List<num> stack){
    applyOperator(stack, (a, b) => a - b);
  }
}

class DivideCommand implements Command{
  void apply(List<num> stack){
    applyOperator(stack, (a, b) => a / b);
  }
}

class MultiplyCommand implements Command{
  void apply(List<num> stack){
    applyOperator(stack, (a, b) => a*b);
  }
}

class Calculator{
  List<num> stack = [];

  Calculator(this.stack);

  push(num value){
    stack.add(value);
  }
  Calculator execute(Command command){
    command.apply(stack);
    return this;
  }
}

