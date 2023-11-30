import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/configs/appcolor.dart';

class Adaptextformfield extends StatelessWidget {
  const Adaptextformfield(
      {super.key,
      this.tohide = false,
      this.controller,
      this.hinttext,
      this.textInputType,
      this.inputFormatters,
      this.icon,
      this.validator,
      this.onchanged,
      this.maxline = 1});

  final bool tohide;
  final TextEditingController? controller;
  final String? hinttext;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? icon;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final int? maxline;
  final Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    final obscure = ValueNotifier<bool>(true);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ValueListenableBuilder(
          valueListenable: obscure,
          builder: (context, hide, child) {
            final bool obs = tohide && hide;
            return SizedBox(
              width: size.width - 50,
              child: TextFormField(
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.justify,
                obscuringCharacter: '*',
                controller: controller,
                obscureText: obs,
                inputFormatters: inputFormatters,
                autocorrect: true,
                showCursor: true,
                keyboardType: textInputType,
                validator: validator,
                cursorColor: AppColors.purple,
                onChanged: onchanged,
                maxLines: maxline,
                decoration: InputDecoration(
                    iconColor: AppColors.grey,
                    suffixIconColor: Theme.of(context).disabledColor,
                    prefixIconColor: Theme.of(context).disabledColor,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.purple, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).unselectedWidgetColor,
                            width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: icon != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(icon, size: 30))
                        : tohide
                            ? const Icon(Icons.lock, size: 30)
                            : null,
                    labelText: hinttext,
                    alignLabelWithHint: true,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    suffixIcon: tohide
                        ? IconButton(
                            onPressed: () => obscure.value = !hide,
                            icon: Icon(hide
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined))
                        : null),
              ),
            );
          }),
    );
  }
}
