import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CardType extends StatefulWidget {

  final String image;
  final String label;
  final bool isSelected;
  final void Function() onTap;
  final bool? haveSquare;
  final bool isAllSelected;

  const CardType({
    Key? key,
    required this.image,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.haveSquare,
    required this.isAllSelected,
  }) : super(key: key);

  @override
  State<CardType> createState() => _CardTypeState();
}

class _CardTypeState extends State<CardType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Opacity(
        opacity: widget.isAllSelected == true ? 1 :  widget.isSelected ? 1 : 0.4,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:[Color(0xFF131D58), Color(0xFF1B2565), ]
              ),
              border: Border.all(
                color: Color(0xFF243189),
                width: 1
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            height: 120,
            width: 104,
            child: Stack(
              children: [
                Visibility(
                  visible: widget.haveSquare != null,
                  child: Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 8, 
                      width: 8, 
                      decoration: BoxDecoration(
                        color: widget.isAllSelected == true ? Color(0xFF0E1647) : widget.isSelected ? Color(0xFFE51C44) : Color(0xFF0E1647),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: widget.isAllSelected == true ? Color(0xFF0E1647) : widget.isSelected ? Color(0xFFE51C44) : Color(0xFF0E1647),
                          width: 1
                        )
                      ),
                    )
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "lib/src/assets/images/${widget.image}"
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.label,
                        style: GoogleFonts.rajdhani(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}