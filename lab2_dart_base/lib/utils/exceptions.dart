void exceptionDemo() {
  try {
    int result = divide(10, 0);
    print('Результат: $result');
  } on IntegerDivisionByZeroException {
    print('Ошибка: Деление на ноль!');
  } finally {
    print('Блок finally выполняется.');
  }
}

int divide(int a, int b) {
  return a ~/ b;
}
