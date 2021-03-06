import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormValidation extends StatefulWidget {
  FormValidation({Key key}) : super(key: key);
  @override
  _FormValidationDemoState createState() => _FormValidationDemoState();
}

class _FormValidationDemoState extends State<FormValidation> {
  final _formKey = GlobalKey<FormState>();
  String adjective;
  String noun;
  bool agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📖 Story Generator'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: FlatButton(
              textColor: Colors.white,
              child: Text('Submit'),
              onPressed: () {
                // Validate the form by getting the FormState from the GlobalKey
                // and calling validate() on it.
                var valid = _formKey.currentState.validate();
                if (!valid) {
                  return;
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Your story'),
                    content: Text('The $adjective developer saw a $noun'),
                    actions: [
                      FlatButton(
                        child: Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // A text field that validates that the text is an adjective.
                TextFormField(
                  validator: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'e.g. quick, beautiful, interesting',
                    labelText: 'Enter an adjective',
                  ),
                  onChanged: (value) {
                    adjective = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                // A text field that validates that the text is a noun.
                TextFormField(
                  validator: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'i.e. a person, place or thing',
                    labelText: 'Enter a noun',
                  ),
                  onChanged: (value) {
                    noun = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                // A custom form field that requires the user to check a
                // checkbox.
                FormField(
                  initialValue: false,
                  validator: (value) {
                    if (value == false) {
                      return 'You must agree to the terms of service.';
                    }
                    return null;
                  },
                  builder: (FormFieldState formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) {
                                // When the value of the checkbox changes,
                                // update the FormFieldState so the form is
                                // re-validated.
                                formFieldState.didChange(value);
                                setState(() {
                                  agreedToTerms = value;
                                });
                              },
                            ),
                            Text(
                              'I agree to the terms of service.',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        if (!formFieldState.isValid)
                          Text(
                            formFieldState.errorText ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).errorColor),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
