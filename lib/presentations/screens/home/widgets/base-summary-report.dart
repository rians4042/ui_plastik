import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/values/colors.dart';

class BaseSummaryReport extends StatelessWidget {
  final String label;
  final String value;
  final bool loading;
  final bool error;
  final Function onRetry;

  BaseSummaryReport({
    @required this.label,
    @required this.value,
    @required this.loading,
    @required this.error,
    @required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: GREY_COLOR,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Wrap(
              children: <Widget>[
                loading == true
                    ? LoadingIndicator()
                    : error == true
                        ? Container(
                            margin: EdgeInsets.only(top: 16),
                            child: GestureDetector(
                              onTap: onRetry,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.refresh,
                                    color: PRIMARY_COLOR,
                                    size: 24,
                                  ),
                                  Text(
                                    'Coba Lagi',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(
                            value,
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
