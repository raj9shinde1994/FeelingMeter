import 'package:feeling_meter/common_widget/base_screen_widget.dart';
import 'package:flutter/material.dart';

mixin BaseScreen<Page extends BasePageScreen> on BasePageScreenState<Page> {
  @override
  Widget build(BuildContext context) {
    if (!useBuildHierarchy()) return body(context);

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: showAppBar()
            ? getAppBar()
            : PreferredSize(
          child: getAppBar(),
          preferredSize: const Size.fromHeight(0.0),
        ),
        resizeToAvoidBottomInset: true,
        floatingActionButton: floatingActionWidget(context),
        body: body(context),
      ),
    );
  }

  Widget floatingActionWidget(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget body(BuildContext context);

  bool showAppBar() => true;
}
