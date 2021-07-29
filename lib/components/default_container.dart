import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;

  DefaultContainer({
    this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: style.copyWith(
          statusBarColor: Color(0x00000000),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: child,
        ),
      ),
    );
  }
}
