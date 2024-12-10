import 'package:dynamic_chekbox_collections/custom_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
  }

  static List<String> chekboxItems = [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven"
  ];

  static ValueNotifier<List<bool>> checkBoxValues =
      ValueNotifier<List<bool>>(List.filled(chekboxItems.length, false));

  List<String> getSelectedTitles() {
    List<String> selected = [];
    for (int i = 0; i < chekboxItems.length; i++) {
      if (checkBoxValues.value[i]) {
        selected.add(chekboxItems[i]);
      }
    }
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            child: ElevatedButton(
                onPressed: () {
                  print(getSelectedTitles());
                },
                child: Text("print selected text")),
          ),
          Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, int indx) {
                      //! index ==i of loop
                      String itemText = chekboxItems[indx];

                      return ValueListenableBuilder<List<bool>>(
                        valueListenable: checkBoxValues,
                        builder: (BuildContext, List<bool> itemValues, _) {
                          bool itemValue = itemValues[indx];
                          return customCard(
                              itemText: itemText,
                              itemValue: itemValue,
                              checkBoxValues: checkBoxValues,
                              indx: indx);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext ctx, int indx) =>
                        const SizedBox(
                      height: 10,
                    ),
                    itemCount: 5,
                  ))),
        ],
      ),
    );
  }
}

class customCard extends StatelessWidget {
  final String itemText;
  final bool itemValue;
  final ValueNotifier<List<bool>> checkBoxValues;
  final int indx;

  const customCard(
      {super.key,
      required this.itemText,
      required this.itemValue,
      required this.checkBoxValues,
      required this.indx});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              itemText,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Checkbox(
                value: itemValue,
                onChanged: (newValue) {
                  if (newValue != null) {
                    List<bool> updatedValues = List.from(checkBoxValues.value);
                    updatedValues[indx] = newValue;
                    checkBoxValues.value = updatedValues;
                  }
                }),
          ],
        ),
      ),
    );
  }
}
