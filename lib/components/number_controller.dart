import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

class NumberController extends StatefulWidget {
  @override
  _NumberControllerState createState() => _NumberControllerState();
}

class _NumberControllerState extends State<NumberController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.minimize, size: 24),
          )),
          Container(
            margin: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: '0',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.w),
                  ),
                  borderSide: BorderSide(
                    color: AppTheme.textFieldBorderColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.textFieldBorderColor,
                    width: 1,
                  ),
                ),
              ),
              // controller: purchaseTextFieldController,
            ),
          ),
          Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add, size: 24),
            ),
          )
        ],
      ),
    );
  }
}
