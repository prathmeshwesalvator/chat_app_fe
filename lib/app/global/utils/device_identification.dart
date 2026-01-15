import 'package:flutter/cupertino.dart';

  bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 425 ? true : false;
  }

  bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 425 &&
            MediaQuery.sizeOf(context).width < 768
        ? true
        : false;
  }

  bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 768 ? true : false;
  }
