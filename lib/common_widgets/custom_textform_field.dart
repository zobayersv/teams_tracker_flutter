import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location_tracker/assets_helper/app_colors.dart';
import 'package:location_tracker/constants/text_font_style.dart';

typedef CustomTextFormField = CustomTextField;

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final int? maxline;
  final int? minLine;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Border? border;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool prefixIconTopLeft;
  final double prefixIconOffsetY; // + moves icon down, - moves it up
  final double? height;

  final bool isObsecure;
  final bool isPass;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? hintTextSyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization? textCapitalization;

  final bool? isEnabled;
  final bool isRead;
  final bool autoFocus;

  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? cursorColor;
  final String? prefixText;

  final TextAlign textAlign;
  final VoidCallback? ontap;
  final String? title;
  final EdgeInsetsGeometry? margin;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.inputType,
    this.maxline = 1,
    this.minLine,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconTopLeft = false,
    this.prefixIconOffsetY = 2.5,
    this.isObsecure = false,
    this.isPass = false,
    this.height,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.contentPadding,
    this.onChanged,
    this.inputFormatters,
    this.labelStyle,
    this.isEnabled,
    this.style,
    this.isRead = false,
    this.borderRadius,
    this.fillColor,
    this.hintTextSyle,
    this.borderColor,
    this.textAlign = TextAlign.left,
    this.ontap,
    this.title,
    this.margin,
    this.autoFocus = false,
    this.maxLength,
    this.cursorColor,
    this.prefixText,
    this.border,
    this.textCapitalization,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  // Height of one text line (used for multi-line top-left layout).
  static const double _baseLineHeight = 24;

  @override
  void initState() {
    _obscureText = widget.isObsecure;
    super.initState();
  }

  // Icon with the vertical nudge applied.
  Widget _nudgedIcon() {
    return Transform.translate(
      offset: Offset(0, widget.prefixIconOffsetY.h),
      child: widget.prefixIcon,
    );
  }

  // ---------------- PREFIX ICON AT TOP-LEFT ----------------
  Widget _buildTopLeftPrefixField() {
    final bool isSingleLine = (widget.maxline ?? 1) == 1;

    return Container(
      padding:
          widget.contentPadding ??
          EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: widget.fillColor ?? AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 14.r),
        border: widget.border,
      ),
      child: Row(
        crossAxisAlignment: isSingleLine
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: isSingleLine ? null : _baseLineHeight.h,
            child: Center(child: _nudgedIcon()),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              minLines: widget.minLine,
              maxLines: widget.maxline,
              controller: widget.controller,
              autofocus: widget.autoFocus,
              maxLength: widget.maxLength,
              readOnly: widget.isRead,
              validator: widget.validator,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.inputType,
              focusNode: widget.focusNode,
              enabled: widget.isEnabled ?? true,
              textAlign: widget.textAlign,
              onTap: widget.ontap,
              cursorColor: widget.cursorColor ?? Colors.black,
              style: widget.style ?? TextFontStyle.sfpro16w400Secondary,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: isSingleLine
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(vertical: 2.h),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle:
                    widget.hintTextSyle ??
                    TextFontStyle.sfpro16w400Secondary.copyWith(
                      color: AppColors.cA7A7A7,
                    ),
                counterText: "",
                prefixText: widget.prefixText,
                prefixStyle: TextFontStyle.sfpro16w400Secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- NORMAL FIELD ----------------
  Widget _buildNormalField() {
    return TextFormField(
      minLines: widget.minLine,
      autofocus: widget.autoFocus,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      readOnly: widget.isRead,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      onTap: widget.ontap,
      style: widget.style ?? TextFontStyle.sfpro16w400Secondary,
      cursorColor: widget.cursorColor ?? Colors.black,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      maxLines: widget.isPass || _obscureText ? 1 : widget.maxline,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      enabled: widget.isEnabled ?? true,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      obscuringCharacter: "*",
      keyboardType: widget.inputType,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        constraints: widget.height != null
            ? BoxConstraints(
                maxHeight: widget.height!,
                minHeight: widget.height!,
              )
            : null,
        isDense: true,
        filled: true,
        fillColor: widget.fillColor ?? AppColors.cFFFFFF,
        contentPadding:
            widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: widget.hintText,
        hintStyle:
            widget.hintTextSyle ??
            TextFontStyle.sfpro14w400Primary.copyWith(color: AppColors.cA7A7A7),

        // PREFIX ICON
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.only(left: 12.w, right: 10.w),
                child: _nudgedIcon(),
              )
            : null,
        prefixIconConstraints: widget.prefixIcon != null
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
        prefixText: widget.prefixText,
        prefixStyle: TextFontStyle.sfpro16w400Secondary,

        // SUFFIX / PASSWORD
        suffixIcon: widget.isPass
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: InkWell(
                  onTap: () => setState(() => _obscureText = !_obscureText),
                  child: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.secondaryColor,
                    size: 20.sp,
                  ),
                ),
              )
            : widget.suffixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: widget.suffixIcon,
              )
            : null,
        suffixIconConstraints: (widget.suffixIcon != null || widget.isPass)
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.cFFFFFF,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.cFFFFFF,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        counterText: "",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null && widget.title!.isNotEmpty) ...[
            Text(widget.title!, style: TextFontStyle.sfpro14w400Secondary),
            SizedBox(height: 10.sp),
          ],
          if (widget.prefixIconTopLeft && widget.prefixIcon != null)
            _buildTopLeftPrefixField()
          else
            _buildNormalField(),
        ],
      ),
    );
  }
}
