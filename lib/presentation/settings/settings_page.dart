import 'package:Sepetim/application/dynamic_links/dynamic_links_bloc.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/default_padding.dart';
import 'package:Sepetim/presentation/core/widgets/logo.dart';
import 'package:Sepetim/presentation/settings/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sepetim',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeightByScalar(
                  context,
                  scalarSmall: 0.02,
                  scalarMedium: 0.03,
                  scalarBig: 0.03,
                ),
              ),
              LogoCenter(
                height: screenHeightByScalar(
                  context,
                  scalarSmall: 0.12,
                  scalarMedium: 0.12,
                  scalarBig: 0.14,
                ),
              ),
              SizedBox(
                height: screenHeightByScalar(
                  context,
                  scalarSmall: 0.02,
                  scalarMedium: 0.04,
                  scalarBig: 0.04,
                ),
              ),
              Center(
                child: Text(
                  'Sepetim - 1.0.0',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                translate(context, 'settings'),
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 15.0,
              ),
              themesButton(context),
              const SizedBox(
                height: 15.0,
              ),
              contactUsButton(context, onPressed: () {}),
              const SizedBox(
                height: 15.0,
              ),
              shareAppButton(context),
              const SizedBox(
                height: 15.0,
              ),
              termsOfServiceButton(context, onPressed: () {}),
              const SizedBox(
                height: 15.0,
              ),
              privacyPolicyButton(context, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
