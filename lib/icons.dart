import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

const String assetName = 'assets/icons/42_logo.svg';

final Widget logo42 = SvgPicture.asset(assetName,
    semanticsLabel: 'Acme Logo', fit: BoxFit.scaleDown, height: 60, width: 60);
