import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  final String submitButtonText;

  const PostForm({
    super.key,
    required this.submitButtonText,
  });

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final List<int> _yearValues = [];

  @override
  void initState() {
    for (int i = 2080; i >= 2000; i--) {
      _yearValues.add(i);
    }
    super.initState();
  }

  static const List<String> _monthValues = [
    "Baisakh",
    "Jestha",
    "Ashad",
    "Shrawan",
    "Bhadra",
    "Ashwin",
    "Kartik",
    "Mangsir",
    "Poush",
    "Magh",
    "Falgun",
    "Chaitra",
  ];
  String _selectedMonth = "Baisakh";

  int? _year;
  int? _day;

  String? _citizenshipNo;
  String? _issuedDistrict;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    int month = _monthValues.indexOf(_selectedMonth) + 1;

    String date = '$_year-$month-$_day';

    print("citizen: $_citizenshipNo,\n district: $_issuedDistrict,\n Date: $date");

    //TODO: submit
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                labelText: 'Citizenship No.',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your citizenship no.';
                }
                return null;
              },
              onSaved: (String? value) {
                _citizenshipNo = value!;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                labelText: 'Issued District',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter issue date';
                }
                return null;
              },
              onSaved: (String? value) {
                _issuedDistrict = value!;
              },
            ),
            const SizedBox(height: 20),
            const Text("Issue Date"),
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    items: _yearValues.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      _year = value;
                    },
                  ),
                ),
                Flexible(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    items: _monthValues.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      _selectedMonth = value!;
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      labelText: 'day',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter issue date';
                      }
                      if (int.parse(value) > 31) {
                        return 'Please enter valid date';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _day = int.parse(value!.trim());
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.6,
                  50,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
              onPressed: _submit,
              child: Text(
                widget.submitButtonText,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
