import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weight_tracker/src/app/features/home/logic/blocs/crud_weight_bloc/crud_weight_bloc.dart';
import 'package:weight_tracker/src/app/features/home/logic/model/weight_model.dart';
import 'package:weight_tracker/src/core/Routers/routes.dart';
import 'package:weight_tracker/src/core/services/network/response_status.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/app_extensions_m.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/widget_ext.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../components/widgets/custom_text_field.dart';
import '../../../auth/logic/model/user_model.dart';

class EditeWeightWidget extends HookWidget {
  const EditeWeightWidget({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final weightController =
        useTextEditingController(text: user.weightModel!.weight);
    final txtStatus = useState<String>(weightController.text);
    const sizedBox = SizedBox(
      height: 16,
    );
    return Dialog(
      child: Container(
        height: context.mediaQSize.height * .55,
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
                    '${AppStrings.editeWeightDescString} ${user.weightModel!.weight}',
                    style: context.txtTheme.titleMedium,
                  ),
                  sizedBox,
                  CustomTextField(
                    controller: weightController,
                    onChanged: (String? val) {
                      if (val != null) {
                        txtStatus.value = val;
                      }
                    },
                    fieldKey: 'weight',
                    name: AppStrings.weightString,
                    keyboardType: TextInputType.number,
                  ),
                  BlocConsumer<CrudWeightBloc, CrudWeightState>(
                    listenWhen: (previous, current) =>
                        previous.updateStatus != current.updateStatus,
                    listener: (context, state) {
                      if (state.updateStatus ==
                          const ResponseStatus.success()) {
                        context.pop();
                        context.read<CrudWeightBloc>().add(Reset());
                        state.message.toastAlert(success: true);
                      }
                    },
                    builder: (context, state) {
                      return state.updateStatus ==
                              const ResponseStatus.loading()
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: context.txtTheme.titleLarge,
                                minimumSize: const Size(
                                  double.infinity,
                                  55,
                                ),
                              ),
                              onPressed: txtStatus.value.isEmpty
                                  ? null
                                  : () {
                                      context.read<CrudWeightBloc>().add(
                                            UpdateMyWeight(
                                              UserModel(
                                                id: user.id,
                                                name: user.name,
                                                token: user.token,
                                                weightModel: WeightModel(
                                                  id: user.weightModel!.id,
                                                  time: DateTime.now(),
                                                  weight: txtStatus.value,
                                                ),
                                              ),
                                            ),
                                          );
                                    },
                              child: const Text(
                                AppStrings.editeString,
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
