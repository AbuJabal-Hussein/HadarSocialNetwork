import 'package:flutter/cupertino.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckBoxForCategories extends StatefulWidget {
  final List<HelpRequestType> types;

  final BuildContext currContext;

  late final _CheckBoxForCategoriesState state;

  CheckBoxForCategories(this.types, this.currContext){
    state = _CheckBoxForCategoriesState(types);
  }

  @override
  _CheckBoxForCategoriesState createState() => state;

  List<HelpRequestType> getSelectedItems() {
    return state.getSelectedItems();
  }
}

class _CheckBoxForCategoriesState extends State<CheckBoxForCategories> {
  final List<HelpRequestType> types;
  List<HelpRequestType> selectedItems = [];
  final formKey = new GlobalKey<FormState>();

  _CheckBoxForCategoriesState(this.types);

  List<HelpRequestType> getSelectedItems() {
    return selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: MultiSelectDialogField(
                cancelText:
                    Text(AppLocalizations.of(widget.currContext)!.cancel),
                confirmText:
                    Text(AppLocalizations.of(widget.currContext)!.confirm),
                searchHint: AppLocalizations.of(widget.currContext)!.search,
                title: Text(AppLocalizations.of(widget.currContext)!.categories),
                buttonText:
                    Text(AppLocalizations.of(widget.currContext)!.categories),
                searchable: true,
                items: types
                    .map((e) => MultiSelectItem(e, e.description))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  selectedItems = values.map((e) => e as HelpRequestType).toList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

