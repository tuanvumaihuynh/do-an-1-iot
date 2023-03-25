import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class RoomListviewWidget extends StatefulWidget {
  const RoomListviewWidget({super.key});

  @override
  State<RoomListviewWidget> createState() => _RoomListviewWidgetState();
}

class _RoomListviewWidgetState extends State<RoomListviewWidget> {
  int _selectedRoomIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, roomIndex) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: AppSizes.DEFAULT_PADDING),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedRoomIndex = roomIndex;
                      });
                    },
                    child: Text(
                      "Room ${roomIndex}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: _selectedRoomIndex == roomIndex
                              ? FontWeight.bold
                              : FontWeight.w400,
                          color: _selectedRoomIndex == roomIndex
                              ? const Color(0xFF4A4444)
                              : const Color(0xFF958B8A)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          width: AppSizes.DEFAULT_PADDING,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black12),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Icon(
                Icons.my_library_books_outlined,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
