import 'package:flutter/material.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/app_extensions_m.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../components/widgets/custom_text_field.dart';

class EditeWeightWidget extends StatelessWidget {
  const EditeWeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 16,
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            AppStrings.editeWeightString,
            style: context.txtTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          sizedBox,
          const Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppStrings.editeWeightDescString,
                  style: context.txtTheme.titleMedium,
                ),
                sizedBox,
                CustomTextField(
                  fieldKey: 'weight',
                  name: AppStrings.weightString,
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: context.txtTheme.titleLarge,
                    minimumSize: const Size(
                      double.infinity,
                      55,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    AppStrings.editeString,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
