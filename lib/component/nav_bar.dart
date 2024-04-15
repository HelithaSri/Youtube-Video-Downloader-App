import 'package:flutter/material.dart';
import 'package:yt_download_app/screen/about_screen.dart';

class FloatingNavBar extends StatefulWidget {
  const FloatingNavBar({
    super.key,
    this.isShow = true,
    this.nav,
    this.rightIcon,
  });

  final VoidCallback? nav;
  final bool isShow;
  final IconData? rightIcon;

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      right: 15,
      left: 15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(55, 50, 35, 50.99),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                ),
                icon: const Icon(Icons.info),
                color: Colors.white,
              ),
              widget.isShow
                  ? IconButton(
                      onPressed: widget.nav,
                      icon: Icon(widget.rightIcon),
                      color: Colors.white,
                    )
                  : const SizedBox(
                      width: 10.0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
