import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../constants/styles.dart';
import '../models/openai_model.dart';
import 'IdeasScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String gender = "prefer not to say";
  String firstDropdownValue = listOfRelation.first;
  String secondDropdownValue = listOfOccasions.first;
  bool isLoading = false;

  // TODO Api Call Function
  void callApi() async {
    var url = Uri.parse('https://api.openai.com/v1/completions');

    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $apiSecretKey'
    };

    String promptData =
        "Suggest gift ideas for someone who is related to me"
        " as $firstDropdownValue of $gender gender for the occasion of"
        " $secondDropdownValue in budget less than 10,000 rupees with"
        " ${_controller.value.text} as hobbies.";

    print(promptData);
    final data = jsonEncode({
      "model": "text-davinci-003",
      "prompt": promptData,
      "temperature": 0.4,
      "max_tokens": 64,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    });

    if (_formKey.currentState!.validate()) {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        print(response.body);
        final gptData = gptDataFromJson(response.body);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                IdeasScreen(gptResponseData: gptData)));
      }return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBackgroundColor,
          title: Text(
            "Gifts 🤖",
            style: kTitleText,
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10),
                  //   child: Text(
                  //     "gifts by 🤖",
                  //     style: kTitleText,
                  //   ),
                  // ),
                  // const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Who is the gift for?",
                      style: kSubTitleText,
                    ),
                  ),
                  Center(
                    child: DropdownButton<String>(
                      // dropdownColor: myColor,
                      value: firstDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: appBackgroundColor),
                      underline: Container(
                        height: 2,
                        color: appBackgroundColor,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          firstDropdownValue = value!;
                        });
                      },
                      items: listOfRelation
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  GoogleFonts.acme(color: appBackgroundColor)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "What do they identify as?",
                      style: kSubTitleText,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RadioListTile(
                      activeColor: Colors.white,
                      tileColor: appBackgroundColor,
                      title: Text(
                        "Male",
                        style: GoogleFonts.acme(color: Colors.white),
                      ),
                      value: "male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RadioListTile(
                      activeColor: Colors.white,
                      tileColor: appBackgroundColor,
                      title: Text(
                        "Female",
                        style: GoogleFonts.acme(color: Colors.white),
                      ),
                      value: "female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RadioListTile(
                      activeColor: Colors.white,
                      tileColor: appBackgroundColor,
                      title: Text(
                        "Prefer not to say",
                        style: GoogleFonts.acme(color: Colors.white),
                      ),
                      value: "prefer not to say",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "What is the occasion?",
                      style: kSubTitleText,
                    ),
                  ),
                  Center(
                    child: DropdownButton<String>(
                      // dropdownColor: myColor,
                      value: secondDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: appBackgroundColor),
                      underline: Container(
                        height: 2,
                        color: appBackgroundColor,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          secondDropdownValue = value!;
                        });
                      },
                      items: listOfOccasions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  GoogleFonts.acme(color: appBackgroundColor)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Tell me about his/her Hobbies or Interests",
                      style: kSubTitleText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _controller,
                      cursorColor: appBackgroundColor,
                      decoration: const InputDecoration(
                          hintText:
                              'Enter a hobby/interest (Example: Playing Football, Gardening, etc)',
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: appBackgroundColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: myColor))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some hobbies';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 15.0),
                    child: MaterialButton(
                      color: appBackgroundColor,
                      onPressed: () async {
                        callApi();
                      },
                      child: Center(
                          child: isLoading &&
                                  _formKey.currentState!.validate() != false
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Generate Gift Ideas",
                                  style: GoogleFonts.acme(color: Colors.white),
                                )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
