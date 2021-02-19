import 'package:flutter/material.dart';
import 'package:flutter_searchbox/flutter_searchbox.dart';

typedef void SetFiltersApplied(bool value);

class DrawerButtons extends StatefulWidget {
  final SetFiltersApplied setFiltersApplied;
  DrawerButtons(this.setFiltersApplied);

  @override
  _DrawerButtonsState createState() => _DrawerButtonsState();
}

class _DrawerButtonsState extends State<DrawerButtons> {
  Map<dynamic, dynamic> searchWidgetState;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.setFiltersApplied(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchWidgetState = SearchBaseProvider.of(context).getActiveWidgets();
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            color: Theme.of(context).primaryColorDark,
            height: 70,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Apply',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onPressed: () {
                        widget.setFiltersApplied(true);
                        searchWidgetState['author-filter'].triggerCustomQuery();
                        searchWidgetState['ratings-filter']
                            .triggerCustomQuery();
                        searchWidgetState['publication-year-filter']
                            .triggerCustomQuery();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: '|',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              fontSize: 50, fontWeight: FontWeight.w200),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Close',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
