import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController _heightInchesController = TextEditingController();
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _result;
  String? dropdownInchesValue = "Inches";
  String? dropdownFeetValue = "Feet";
  String feet = "", inches = "", weight = "";
  String errorMessage = "";
  String statusMessage = "";

  void calculateBMI() {
    print(_heightInchesController.text);
    if (identical(feet, "") || identical(inches, "") || identical(weight, "")) {
      statusMessage = "";
      createErrorMessage();
    } else {
      errorMessage = "";
      double heightInCM =
          double.parse(inches) * 2.54 + double.parse(feet) * 12 * 2.54;
      double weightInKg = double.parse(weight) / 2.2;
      double heightInM = heightInCM / 100;
      double heightSquared = heightInM * heightInM;
      _result = weightInKg / heightSquared;
      createStatusMessage();
    }
    setState(() {});
  }

  void createStatusMessage() {
    if (_result! < 18.5) {
      statusMessage = "Underweight";
    } else if (_result! <= 25) {
      statusMessage = "Healthy Weight Range";
    } else if (_result! <= 30) {
      statusMessage = "Overweight";
    } else {
      statusMessage = "Severely Overweight";
    }
  }

  void createErrorMessage() {
    if (identical(feet, "")) {
      errorMessage = "Enter Feet\n";
    }
    if (identical(inches, "")) {
      errorMessage = "Enter inches";
    }
    if (identical(weight, "")) {
      errorMessage = "Enter weight";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      //value: dropdownFeetValue,
                      hint: Text(dropdownFeetValue.toString()),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownFeetValue = newValue!;
                          feet = newValue;
                        });
                      },
                      items: <String>['3', '4', '5', '6', '7']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 100),
                    DropdownButton<String>(
                      //value: dropdownInchesValue,
                      hint: Text(dropdownInchesValue.toString()),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownInchesValue = newValue!;
                          inches = newValue;
                        });
                      },
                      items: <String>[
                        '0',
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10',
                        '11'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ]),
              SizedBox(height: 50),
              TextField(
                onChanged: (String? newValue) {
                  setState(() {
                    weight = newValue!;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'weight in lbs',
                ),
              ),
              SizedBox(height: 50),
              OutlinedButton(
                onPressed: calculateBMI,
                child: Text(
                  "Calculate",
                ),
              ),
              SizedBox(height: 50),
              Text('Result'),
              Text(
                _result == null
                    ? "Enter Values"
                    : identical(errorMessage, "")
                        ? "${_result?.toStringAsFixed(2)}"
                        : "",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 19.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                identical(errorMessage, "") ? statusMessage : errorMessage,
                style: TextStyle(
                  fontSize: 19.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
      ),
    );
  }
}
