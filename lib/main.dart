import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          child: MainAppContent(),
        ),
      ),
    );
  }
}

class MainAppContent extends StatefulWidget {
  const MainAppContent({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppContentState();
}

class _MainAppContentState extends State<MainAppContent> {
  double _number = 0.0;
  String _n1 = "";
  String _lastNumber = "";
  String? _operation;

  void setOperationNumber(String n) {
    setState(() {
      _n1 += n;
    });
  }

  void setOperation(String o) {
    setState(() {
      if (_n1.isNotEmpty) {
        if (_operation != null) {
          doOperation();
        } else {
          _lastNumber = _n1;
        }
      }
      _operation = o;
      _n1 = "";
    });
  }

  void doOperation() {
    setState(() {
      double n1 = double.tryParse(_n1) ?? 0.0;
      double lastNumber = double.tryParse(_lastNumber) ?? 0.0;
      if (_operation == "suma") {
        _number = lastNumber + n1;
      } else if (_operation == "resta") {
        _number = lastNumber - n1;
      } else if (_operation == "multiplicacion") {
        _number = lastNumber * n1;
      } else if (_operation == "division") {
        _number = lastNumber / n1;
      }
      _n1 = _number.toString();
      _lastNumber = "";
      _operation = null;
    });
  }

  void reset() {
    setState(() {
      _number = 0.0;
      _n1 = "";
      _lastNumber = "";
      _operation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Calculadora básica para examen",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            expands: false,
            textAlign: TextAlign.end,
            readOnly: true,
            maxLines: 1,
            keyboardType: TextInputType.number,
            canRequestFocus: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                gapPadding: 10,
              ),
              hintText: _n1.isEmpty ? _number.toString() : _n1,
              contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              // Numbers Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 30),
                      numberButton(1, () => setOperationNumber("1")),
                      const SizedBox(width: 10),
                      numberButton(2, () => setOperationNumber("2")),
                      const SizedBox(width: 10),
                      numberButton(3, () => setOperationNumber("3")),
                      const SizedBox(width: 30)
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 30),
                      numberButton(4, () => setOperationNumber("4")),
                      const SizedBox(width: 10),
                      numberButton(5, () => setOperationNumber("5")),
                      const SizedBox(width: 10),
                      numberButton(6, () => setOperationNumber("6")),
                      const SizedBox(width: 30)
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 30),
                      numberButton(7, () => setOperationNumber("7")),
                      const SizedBox(width: 10),
                      numberButton(8, () => setOperationNumber("8")),
                      const SizedBox(width: 10),
                      numberButton(9, () => setOperationNumber("9")),
                      const SizedBox(width: 30)
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 30),
                      operationButton(".", () => setOperationNumber(".")),
                      const SizedBox(width: 10),
                      numberButton(0, () => setOperationNumber("0")),
                      const SizedBox(width: 10),
                      operationButton("=", () => doOperation()),
                      const SizedBox(width: 30)
                    ],
                  ),
                ],
              ),
              // Operations Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  operationButton("+", () => setOperation("suma")),
                  const SizedBox(height: 10),
                  operationButton("-", () => setOperation("resta")),
                  const SizedBox(height: 10),
                  operationButton("*", () => setOperation("multiplicacion")),
                  const SizedBox(height: 10),
                  operationButton("/", () => setOperation("division")),
                  const SizedBox(height: 30),
                  operationButton("CE", () => reset()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

OutlinedButton numberButton(int number, VoidCallback onPressed) {
  return OutlinedButton(
    onPressed: onPressed,
    child: Text(number.toString()),
  );
}

OutlinedButton operationButton(String op, VoidCallback onPressed) {
  return OutlinedButton(
    onPressed: onPressed,
    child: Text(op),
  );
}
