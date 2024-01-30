import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmUI extends StatelessWidget {
  const AlarmUI({super.key, required this.medicine});
  final String medicine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            medicine,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            '8:00 PM',
            style: GoogleFonts.firaMono(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        ]),
      ),
    );
  }
}
