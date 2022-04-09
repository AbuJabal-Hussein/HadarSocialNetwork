import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Dropdown extends StatefulWidget {

  late DropDownState dropDownState;
  final List<HelpRequestType> types;

  Dropdown(this.types) {
    this.dropDownState = DropDownState(types);
  }

  @override
  State createState() => dropDownState;

  HelpRequestType getSelectedType() {
    return dropDownState.getSelectedType();
  }
}

class DropDownState extends State<Dropdown> {
  late HelpRequestType selectedType;

  List<HelpRequestType> types;

  DropDownState(this.types);

  HelpRequestType getSelectedType() {
    return selectedType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasicColor.backgroundClr,
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton<HelpRequestType>(
            hint: Text(AppLocalizations.of(context)!.chooseCategory),
            value: selectedType,
            onChanged: (HelpRequestType? value) {
              setState(
                    () {
                  selectedType = value!;
                },
              );
            },
            items: types.map((HelpRequestType type) {
              return DropdownMenuItem<HelpRequestType>(
                value: type,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.description,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}