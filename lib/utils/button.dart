import 'package:humble_warrior/hw.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.padding,
    this.buttonSize = ButtonSize.large,
  })  : _buttonType = ButtonType.primary,
        super(key: key);

  const Button.outlined({
    Key? key,
    required this.label,
    required this.onTap,
    this.foregroundColor,
    this.width,
    this.padding,
    this.buttonSize = ButtonSize.large,
  })  : _buttonType = ButtonType.outlined,
        backgroundColor = foregroundColor,
        super(key: key);

  const Button.text({
    Key? key,
    required this.label,
    required this.onTap,
    this.foregroundColor,
    this.width,
    this.padding,
    this.buttonSize = ButtonSize.large,
  })  : _buttonType = ButtonType.text,
        backgroundColor = foregroundColor,
        super(key: key);

  const Button.back({
    Key? key,
    this.onTap,
    this.padding,
  })  : label = '',
        backgroundColor = Colors.transparent,
        foregroundColor = Colors.transparent,
        width = 0,
        buttonSize = ButtonSize.large,
        _buttonType = ButtonType.back,
        super(key: key);

  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final double? width;
  final EdgeInsets? padding;
  final ButtonSize buttonSize;

  final ButtonType _buttonType;



  @override
  Widget build(BuildContext context) {
    double fontSize;
    EdgeInsets padding;
    double height;
    OutlinedBorder shape;
    double? width;

    switch (buttonSize) {
      case ButtonSize.small:
        fontSize = 14;

        padding = 16.ph;
        height = 32;
        shape = 8.shape as OutlinedBorder;
        width = null;

        break;
      case ButtonSize.medium:
        fontSize = 20;

        padding = 20.ph;
        height = 40;
        shape = 10.shape as OutlinedBorder;
        width = null;
        break;
      case ButtonSize.large:
      default:
        fontSize = 22;

        padding = 24.ph;
        height = 48;
        shape = 12.shape as OutlinedBorder;
        width = double.maxFinite;
        break;
    }

    switch (_buttonType) {
      case ButtonType.back:
        return IconButton(
          onPressed: onTap ?? () => Navigator.pop(context, false),
          icon: Obx(
            () => Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.secondary,
            ),
          ),
        );
      case ButtonType.outlined:
        return Padding(
          padding: padding ,
          child: SizedBox(
            height: height,
            width: width ?? width,
            child: _OutlinedButton(
              label: label,
              color: foregroundColor,
              fontSize: fontSize,
              onTap: onTap,
              padding: padding,
              shape: shape,
            ),
          ),
        );
      case ButtonType.text:
        return Padding(
          padding: padding,
          child: SizedBox(
            height: height,
            width: width ?? width,
            child: _TextButton(
              label: label,
              color: foregroundColor,
              fontSize: fontSize,
              onTap: onTap,
              padding: padding,
              shape: shape,
            ),
          ),
        );
      case ButtonType.primary:
      default:
        return Padding(
          padding: padding ,
          child: SizedBox(
            height: height,
            width: width ?? width,
            child: _PrimaryButton(
              label: label,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              fontSize: fontSize,
              onTap: onTap,
              padding: padding,
              shape: shape,
            ),
          ),
        );
    }
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    Key? key,
    this.label,
    this.padding,
    this.fontSize,
    this.foregroundColor,
    this.backgroundColor,
    this.onTap,
    this.shape,
  }) : super(key: key);

  final String? label;
  final EdgeInsets? padding;
  final double? fontSize;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final OutlinedBorder? shape;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: padding,
        shape: shape,
      ),
      onPressed: onTap,
      child: AppText(
        label!,
        // fontSize: fontSize,
        color: foregroundColor ?? AppColors.primary,
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({
    Key? key,
    this.label,
    this.padding,
    this.fontSize,
    this.color,
    this.onTap,
    this.shape,
  }) : super(key: key);

  final String? label;
  final EdgeInsets? padding;
  final double? fontSize;
  final Color? color;
  final VoidCallback? onTap;
  final OutlinedBorder? shape;



  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) => padding),
        shape: MaterialStateProperty.resolveWith((states) => shape),
        side: MaterialStateProperty.resolveWith(
          (states) => BorderSide(
            color: color! ,
            width: 2,
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (state) => Get.textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> buttonStates) {
          if (buttonStates.contains(MaterialState.pressed)) {
            return color  ;
          }
          return color ?? Colors.transparent;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> buttonStates) {
          if (buttonStates.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return color ;
        }),
      ),
      onPressed: onTap,
      child: Text(
        label!,
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    Key? key,
    this.label,
    this.padding,
    this.fontSize,
    this.color,
    this.onTap,
    this.shape,
  }) : super(key: key);

  final String? label;
  final EdgeInsets? padding;
  final double? fontSize;
  final Color? color;
  final VoidCallback? onTap;
  final OutlinedBorder? shape;



  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(

        padding: padding,
        shape: shape,
      ),
      onPressed: onTap,
      child: AppText(
        label!,

        color: color
      ),
    );
  }
}

class CameraIcon extends StatelessWidget {
  const CameraIcon({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primary,
      child: Icon(
        Icons.camera_alt_rounded,
        color: AppColors.primary,
      ),
    );
  }
}
