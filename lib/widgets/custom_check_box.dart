
import 'package:fittyus/constants/constants.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onChanged(!value);
          },
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
                color: value ? mainColor : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFfCCCCCC))),
            child: Center(
              child: value
                  ? Icon(
                Icons.done,
                color: Colors.white,
                size: Dimensions.iconSize14,
              )
                  : const SizedBox(),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: TextStyle(
              fontFamily: medium,
              fontStyle: FontStyle.normal,
              fontSize: 13,
              color: value ? mainColor : const Color(0xFF556B74),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}