import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/utils/validators.dart';

class CpfCnpjTextForm extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final String hintText;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String? initialValue;
  final String label;
  final AppPalette palette;

  const CpfCnpjTextForm({
    required this.constraints,
    this.controller,
    required this.hintText,
    required this.label,
    this.validator,
    this.onSaved,
    this.height,
    this.width,
    this.initialValue,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 90 : constraints.maxHeight * height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette.titleColor,
        ),
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfOuCnpjFormatter(),
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: constraints.maxHeight * .025,
              color: Colors.black.withOpacity(.8),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.titleColor,
                width: constraints.maxWidth * .004,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.titleColor,
                width: constraints.maxWidth * .004,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: constraints.maxHeight * .02,
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownTextForm extends StatelessWidget {
  final BoxConstraints constraints;
  final List<String> dropdownItems;
  final String selectedItem;
  final String hintText;
  final String label;
  final bool? isEnabled;
  final void Function(String? text)? onSaved;
  final void Function(String? value)? onChanged;
  final String? Function(String? text)? validator;
  final double? width;
  final Color? backgroundColor;
  final AppPalette? palette;

  const DropdownTextForm({
    required this.constraints,
    required this.dropdownItems,
    required this.hintText,
    required this.selectedItem,
    required this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.isEnabled,
    this.width,
    this.backgroundColor = Colors.white,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: DropdownButtonFormField<String>(
        isDense: true,
        isExpanded: true,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: palette!.titleColor,
        ),
        dropdownColor: backgroundColor,
        style: TextStyle(
          color: palette!.titleColor,
          fontWeight: FontWeight.w600,
        ),
        value: selectedItem.isNotEmpty ? selectedItem : null,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(label),
          labelStyle: TextStyle(
            fontSize: constraints.maxHeight * .025,
            color: palette!.titleColor,
          ),
          filled: true,
          fillColor: backgroundColor,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(206, 36, 36, 1),
              width: constraints.maxWidth * .004,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(206, 36, 36, 1),
              width: constraints.maxWidth * .004,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: palette!.titleColor,
              width: constraints.maxWidth * .004,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: palette!.titleColor,
              width: constraints.maxWidth * .004,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: constraints.maxHeight * .02,
          ),
        ),
        hint: Text(
          hintText,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: constraints.maxHeight * .018,
            color: palette!.titleColor,
          ),
        ),
        onChanged: onChanged,
        onSaved: onSaved,
        items: dropdownItems
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DateFormField extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text) validator;
  final String hintText;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String? initialValue;
  final String label;
  final AppPalette? palette;

  const DateFormField({
    required this.constraints,
    this.controller,
    required this.hintText,
    required this.validator,
    this.onSaved,
    this.height,
    this.width,
    this.initialValue,
    required this.label,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 65 : constraints.maxHeight * height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette!.titleColor,
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DataInputFormatter(),
          ],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: constraints.maxHeight * .025,
              color: Colors.black.withOpacity(.8),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette!.titleColor,
                width: constraints.maxWidth * .004,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette!.titleColor,
                width: constraints.maxWidth * .004,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: constraints.maxHeight * .02,
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneFormField extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text) validator;
  final String hintText;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String? initialValue;
  final String label;
  final AppPalette palette;

  const PhoneFormField({
    required this.constraints,
    this.controller,
    required this.hintText,
    required this.validator,
    this.onSaved,
    this.height,
    this.width,
    this.initialValue,
    required this.label,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 65 : constraints.maxHeight * height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette.titleColor,
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter(),
          ],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: constraints.maxHeight * .025,
              color: Colors.black.withOpacity(.8),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.titleColor,
                width: constraints.maxWidth * .004,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.titleColor,
                width: constraints.maxWidth * .004,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: constraints.maxHeight * .02,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormFieldWithHelper extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final String hintText;
  final int? maxLength;
  final String? helperText;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String? initialValue;
  final String label;
  final AppPalette palette;

  const CustomTextFormFieldWithHelper({
    required this.constraints,
    this.controller,
    required this.hintText,
    this.maxLength,
    this.validator,
    this.onSaved,
    this.height,
    this.width,
    this.helperText = "",
    required this.label,
    this.initialValue,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 90 : constraints.maxHeight * height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette.titleColor,
        ),
        child: TextFormField(
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: constraints.maxHeight * .025,
              color: Colors.black.withOpacity(.8),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.titleColor,
                width: constraints.maxWidth * .004,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.titleColor,
                width: constraints.maxWidth * .004,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: constraints.maxHeight * .02,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormFieldLogin extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String? text)? validator;
  final String hintText;
  final int? maxLength;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String? initialValue;
  final String label;
  final AppPalette? palette;

  const CustomTextFormFieldLogin({
    required this.constraints,
    this.controller,
    required this.hintText,
    this.maxLength,
    this.validator,
    this.onSaved,
    this.height,
    this.width,
    this.focusNode,
    required this.label,
    this.initialValue,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 80 : height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette!.titleColor,
        ),
        child: TextFormField(
          focusNode: focusNode,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: 14,
              color: AppPalette.darkColorPalette.titleColor,
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(206, 36, 36, 1),
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(206, 36, 36, 1),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppPalette.darkColorPalette.titleColor.withOpacity(.4),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppPalette.darkColorPalette.titleColor.withOpacity(.4),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppPalette.darkColorPalette.titleColor,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String? text)? validator;
  final String hintText;
  final int? maxLength;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String? initialValue;
  final String label;
  final AppPalette? palette;

  const CustomTextFormField({
    required this.constraints,
    this.controller,
    required this.hintText,
    this.maxLength,
    this.validator,
    this.onSaved,
    this.height,
    this.width,
    this.focusNode,
    required this.label,
    this.initialValue,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 80 : height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette!.titleColor,
        ),
        child: TextFormField(
          focusNode: focusNode,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(.8),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(206, 36, 36, 1),
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(206, 36, 36, 1),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette!.titleColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette!.titleColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text) validator;
  final String hintText;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String label;
  final AppPalette? palette;

  const PasswordTextField({
    required this.constraints,
    this.controller,
    required this.hintText,
    required this.validator,
    required this.label,
    this.onSaved,
    this.height,
    this.width,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? 100 : constraints.maxHeight * height!,
      width: width == null ? constraints.maxWidth * .9 : constraints.maxWidth * width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette!.titleColor,
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          onSaved: onSaved,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: 14,
              color: AppPalette.darkColorPalette.titleColor,
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(206, 36, 36, 1),
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(206, 36, 36, 1),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppPalette.darkColorPalette.titleColor.withOpacity(.4),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppPalette.darkColorPalette.titleColor.withOpacity(.4),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppPalette.darkColorPalette.titleColor,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTextField2 extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text) validator;
  final String hintText;
  final String? initialValue;
  final String? helperText;
  final String label;
  final void Function()? onTap;
  final void Function(String? text)? onSaved;
  final void Function(String? text)? onChanged;
  final AppPalette? palette;

  const SearchTextField2({
    required this.constraints,
    this.controller,
    required this.hintText,
    required this.validator,
    this.onTap,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.helperText,
    required this.label,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: constraints.maxWidth * .9,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: palette!.titleColor,
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          onSaved: onSaved,
          onChanged: onChanged,
          decoration: InputDecoration(
            helperText: helperText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: constraints.maxHeight * .025,
              color: Colors.black.withOpacity(.8),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: constraints.maxWidth * .004,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette!.titleColor,
                width: constraints.maxWidth * .004,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette!.titleColor,
                width: constraints.maxWidth * .004,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: constraints.maxHeight * .02,
            ),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Container(
                height: constraints.maxHeight * .07,
                width: constraints.maxWidth * .12,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: Icon(
                  Icons.search,
                  color: palette!.titleColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordWithObscureTextField extends StatefulWidget {
  final BoxConstraints constraints;
  final TextEditingController? controller;
  final String? Function(String? text) validator;
  final String hintText;
  final void Function(String? text)? onSaved;
  final double? height;
  final double? width;
  final String label;
  final AppPalette? palette;

  const PasswordWithObscureTextField({
    required this.constraints,
    this.controller,
    required this.hintText,
    required this.validator,
    required this.label,
    this.onSaved,
    this.height,
    this.width,
    this.palette = AppPalette.lightColorPalette,
  });

  @override
  State<PasswordWithObscureTextField> createState() => _PasswordWithObscureTextFieldState();
}

class _PasswordWithObscureTextFieldState extends State<PasswordWithObscureTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height == null ? 100 : widget.constraints.maxHeight * widget.height!,
      width: widget.width == null ? widget.constraints.maxWidth * .9 : widget.constraints.maxWidth * widget.width!,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: widget.palette!.titleColor,
        ),
        child: TextFormField(
          obscureText: isObscured,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          controller: widget.controller,
          onSaved: widget.onSaved,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(widget.label),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: widget.constraints.maxWidth * .004,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromRGBO(206, 36, 36, 1),
                width: widget.constraints.maxWidth * .004,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.palette!.titleColor,
                width: widget.constraints.maxWidth * .004,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.palette!.titleColor,
                width: widget.constraints.maxWidth * .004,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscured = !isObscured;
                });
              },
              child: Icon(
                isObscured ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: widget.constraints.maxHeight * .02,
            ),
          ),
        ),
      ),
    );
  }
}

/*
class AutoCompleteTextField extends StatelessWidget {
  final List<BankModel> bankList;
  final BoxConstraints constraints;
  final TextEditingController textEditingController;
  final void Function(String? text)? onSaved;

  AutoCompleteTextField({
    required this.bankList,
    required this.constraints,
    required this.textEditingController,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<BankModel>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<BankModel>.empty();
        }
        return bankList.where((BankModel bank) {
          return bank.bankName
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: (option) =>
          '${option.bankCode} - ${option.bankName}',
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return CustomTextFormField(
          constraints: constraints,
          focusNode: focusNode,
          controller: textEditingController,
          hintText: 'Digite o nome do seu banco',
          label: 'Banco',
          onSaved: onSaved,
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<BankModel> onSelected,
        Iterable<BankModel> banks,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: banks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: const EdgeInsets.all(5.0),
                  title: Text(
                    '${banks.elementAt(index).bankCode} - ${banks.elementAt(index).bankName}',
                    style: const TextStyle(
                      color: AplikitPalette.LOW_OPACITY_BLACK,
                    ),
                  ),
                  onTap: () {
                    onSelected(banks.elementAt(index));
                  },
                );
              },
            ),
          ),
        );
      },
      onSelected: (BankModel bank) {
        textEditingController.text = bank.bankName;
        // Adicione aqui as ações que deseja realizar quando uma string é selecionada.
      },
    );
  }
}
*/