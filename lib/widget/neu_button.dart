import 'package:colorgame/utils/utils.dart';
import 'package:flutter/material.dart';

class NeuButton extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;
  final double position;
  final double shadowLength;
  final double shadowFallLength;
  final bool switchShadow;
  final Map<String, Color> lightAndDarkShadow;

  final BorderRadius borderRadius;
  final VoidCallback onTap;
  final bool isChoose;
  const NeuButton({
    Key key,
    @required this.child,
    @required this.position,
    this.height,
    this.width,
    this.onTap,
    this.lightAndDarkShadow,
    @required this.shadowLength,
    this.shadowFallLength = 1,
    @required this.borderRadius,
    this.switchShadow = false,
    this.isChoose = false,
  }) : super(key: key);

  @override
  _NeuButtonState createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton>
    with SingleTickerProviderStateMixin {
  bool onLongPress = false;
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    animation = CurvedAnimation(
      curve: Curves.decelerate,
      parent: animationController,
    );
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  LinearGradient getGradient() {
    if (widget.isChoose) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.darkShadow,
          AppColors.lightShadow,
        ],
      );
    }
    if (widget.lightAndDarkShadow != null) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          onLongPress
              ? widget.lightAndDarkShadow['darkShadow']
              : widget.lightAndDarkShadow['lightShadow'],
          onLongPress
              ? widget.lightAndDarkShadow['lightShadow']
              : widget.lightAndDarkShadow['darkShadow'],
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          onLongPress ? AppColors.darkShadow : AppColors.lightShadow,
          onLongPress ? AppColors.lightShadow : AppColors.darkShadow,
        ],
      );
    }
  }

  List<BoxShadow> getBoxShadow() {
    if (widget.isChoose) {
      return [
        BoxShadow(
          color: AppColors.darkShadow.withOpacity(0.3),
          offset: Offset(-widget.shadowLength, -widget.shadowLength),
          blurRadius: widget.shadowLength - widget.shadowFallLength,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: AppColors.lightShadow,
          offset: Offset(widget.shadowLength, widget.shadowLength),
          blurRadius: widget.shadowLength - widget.shadowFallLength,
          spreadRadius: -1,
        ),
      ];
    }
    if (widget.switchShadow) {
      return [
        BoxShadow(
          color: onLongPress
              ? AppColors.lightShadow
              : AppColors.darkShadow.withOpacity(0.3),
          offset: Offset(-widget.shadowLength, -widget.shadowLength),
          blurRadius: widget.shadowLength - widget.shadowFallLength,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: onLongPress
              ? AppColors.darkShadow.withOpacity(0.3)
              : AppColors.lightShadow,
          offset: Offset(widget.shadowLength, widget.shadowLength),
          blurRadius: widget.shadowLength - widget.shadowFallLength,
          spreadRadius: -1,
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: onLongPress
              ? AppColors.darkShadow.withOpacity(0.3)
              : AppColors.lightShadow,
          offset: Offset(-widget.shadowLength, -widget.shadowLength),
          blurRadius: widget.shadowLength - widget.shadowFallLength,
          spreadRadius: -1,
        ),
        BoxShadow(
          color: onLongPress
              ? AppColors.lightShadow
              : AppColors.darkShadow.withOpacity(0.3),
          offset: Offset(widget.shadowLength, widget.shadowLength),
          blurRadius: widget.shadowLength - widget.shadowFallLength,
          spreadRadius: -1,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onLongPress = true;
          animationController.forward();
        });
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            onLongPress = false;
            animationController.reverse();
          });
          Future.delayed(Duration(milliseconds: 300), () {
            if (widget.onTap != null) widget.onTap();
          });
        });
      },
      onLongPress: () {
        setState(() {
          onLongPress = true;
          animationController.forward();
        });
      },
      onLongPressEnd: (onLongPressEnd) {
        setState(() {
          onLongPress = false;
          animationController.reverse();
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,
        height: widget.height ?? MediaQuery.of(context).size.height / 2,
        width: widget.width ?? MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
          color: AppColors.darkShadow,
          borderRadius: widget.borderRadius,
          gradient: getGradient(),
          boxShadow: getBoxShadow(),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              top: animation.value * widget.position,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
