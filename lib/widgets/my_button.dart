import 'package:fittyus/constants/constants.dart';

class MyButton extends StatefulWidget {
  final Function() onPressed;
  final Widget child;
  final Color color;

  const MyButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.color})
      : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: widget.child);
  }
}
