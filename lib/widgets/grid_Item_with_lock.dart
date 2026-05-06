import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridItemWithLock extends StatefulWidget {
  final Map<String, String> item;
  const GridItemWithLock({super.key, required this.item});

  @override
  State<GridItemWithLock> createState() => _GridItemWithLockState();
}

class _GridItemWithLockState extends State<GridItemWithLock> {
  late bool isLocked;

  @override
  void initState() {
    super.initState();
    isLocked = widget.item['locked'] == "true";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        if (isLocked) {
          setState(() => isLocked = false);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white.withOpacity(0.06),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Transform.scale(
                scale: 1.4,
                child: Image.asset(
                  'assets/pngs/${widget.item['i']}',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),

            // 2. Text Overlay (Glass effect)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.item['t']!, maxLines: 2, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold)),
                        if (widget.item['s'] != "")
                          Text(widget.item['s']!, maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 7)),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 3. BLACK LOCK OVERLAY (Only visible if isLocked is true)
            if (isLocked)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.7), // Dark opacity layer
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.4),

                          ),
                          child: Text("PREMIUM", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                        ),
                        SvgPicture.asset('assets/svg/lock.svg', height: 25, color: Colors.white,),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}