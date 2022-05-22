import 'package:flutter/material.dart';

abstract class BasePageScreen extends StatelessWidget {
  const BasePageScreen({Key key}) : super(key: key);
}

abstract class BasePageScreenState<Page extends BasePageScreen>{

  PreferredSizeWidget getAppBar();

  bool useBuildHierarchy() => true;
}

