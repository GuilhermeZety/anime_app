import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class Input extends StatefulWidget {
  final String? label;
  final TextInputType keyboard;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? formatter;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool showError;
  final Function(String?)? onChange;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final bool copy;

  const Input(
    this.controller, {
    super.key,
    this.label,
    this.keyboard = TextInputType.text,
    this.formatter,
    this.validation,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.hint,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.copy = false,
    this.showError = true,
    this.onTap,
    this.onChange,
    this.focusNode,
    this.prefixIcon,
  });

  const Input.numeric(
    this.controller, {
    super.key,
    this.label,
    this.keyboard = TextInputType.number,
    this.formatter,
    this.validation,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.hint,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.showError = true,
    this.onTap,
    this.onChange,
    this.focusNode,
    this.prefixIcon,
    this.copy = false,
  });
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    Widget? suffix;

    if (widget.keyboard == TextInputType.visiblePassword) {
      suffix = widget.keyboard == TextInputType.visiblePassword
          ? IconButton(
              color: AppColors.grey_600.withOpacity(0.8),
              icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => visible = !visible),
            )
          : null;
    }
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(widget.label!, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Gap(5),
            ],
            TextFormField(
              key: widget.key,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: widget.controller,
              autovalidateMode: widget.autovalidateMode,
              validator: widget.validation,
              inputFormatters: widget.formatter,
              keyboardType: widget.keyboard,
              minLines: widget.minLines,
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.readOnly,
              obscureText: widget.keyboard == TextInputType.visiblePassword ? !visible : false,
              onChanged: widget.onChange,
              onTap: widget.onTap,
              focusNode: widget.focusNode,
              style: TextStyle(
                color: AppColors.grey_100.withOpacity(0.5),
                fontSize: 18,
              ),
              decoration: InputDecoration(
                suffixIcon: suffix,
                errorMaxLines: 2,
                // label: widget.label,
                prefixIcon: widget.prefixIcon,
                hintText: widget.hint,
              ),
            ),
            if (widget.copy) const Gap(15),
          ],
        ),
        if (widget.copy)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => Utils.copy(context, widget.controller.text),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.purple_400,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.copy_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    Gap(5),
                    Text(
                      'Copiar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
