import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:devti_agro/core/widgets/custom_login/Custom_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Ensure this import is correct

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final SvgPicture? leadingIcon; // Icon for the leading button
  final VoidCallback? leadingAction; // Action for the leading button
  final FaIcon? trailingIcon; // Icon for the trailing button
  final VoidCallback? trailingAction; // Action for the trailing button
  final Widget? scIcon; // Optional: Icon for additional action
  final VoidCallback? scAction; // Optional: Action for the additional icon
  final double? elevation; // Elevation parameter (no default value here)
  final Color? color;
  final bool isShowLogin;

  const CustomAppbar(
      {Key? key,
      required this.title,
      this.leadingIcon,
      this.leadingAction,
      this.trailingIcon,
      this.isShowLogin = false,
      this.trailingAction,
      this.scIcon,
      this.scAction,
      this.elevation, // No default value here
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Color(0xffFAFAFA),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          if (isShowLogin) CustomLogin()
        ],
      ),
      centerTitle: true,
      elevation: elevation ?? 3.0, // Provide a default value if elvation is null
      leading: leadingIcon != null
          ? IconButton(
              color: primaryColor,
              icon: leadingIcon!,
              onPressed: leadingAction ??
                  () {
                    Scaffold.of(context).openDrawer(); // Default action if not provided
                  },
            )
          : null,
      actions: <Widget>[
        if (scIcon != null)
          IconButton(
            icon: scIcon!,
            onPressed: scAction,
          ),
        if (trailingIcon != null)
          IconButton(
            icon: trailingIcon!,
            onPressed: trailingAction,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
