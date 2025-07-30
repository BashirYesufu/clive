import 'package:clive/util/route/app_router.dart';
import 'package:flutter/material.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/ui_actions.dart';

mixin QuantityDelegate {
  void onQuantitySelected(num quantity);
}

class QuantitySheet extends StatefulWidget {
  const QuantitySheet({required this.delegate, super.key});
  final QuantityDelegate delegate;

  static launch(BuildContext context, {required QuantityDelegate delegate}){
    UIActions.showSheet(context, child: QuantitySheet(delegate: delegate,));
  }

  @override
  State<QuantitySheet> createState() => _QuantitySheetState();
}

class _QuantitySheetState extends State<QuantitySheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quantity', style: AppTextStyles.black( size: 16, weight: FontWeight.w600),),
          Expanded(
            child: ListView.builder(
              itemCount: 11,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    AppRouter.goBack(context);
                    widget.delegate.onQuantitySelected(index+1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Text('${index+1}', style: AppTextStyles.black(size: 16, weight: FontWeight.w500),),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
