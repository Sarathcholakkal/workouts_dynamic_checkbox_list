import 'package:flutter/material.dart';

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
