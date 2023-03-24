import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/home_body_widget.dart';

import 'package:do_an_1_iot/ui/views/home/widgets/popup_menu_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedRoomIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.DEFAULT_PADDING,
              vertical: AppSizes.DEFAULT_PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  PopupMenuWidget(),
                  Spacer(),
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 25,
                    color: Color(0xFF2F2B2A),
                  ),
                  SizedBox(width: AppSizes.DEFAULT_PADDING),
                  Icon(
                    Icons.add,
                    size: 30,
                    color: Color(0xFF2F2B2A),
                  )
                ],
              ),
              const SizedBox(height: AppSizes.DEFAULT_PADDING / 2),
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: AppSizes.DEFAULT_PADDING),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedRoomIndex = index;
                                  });
                                },
                                child: Text(
                                  "Room ${index}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: _selectedRoomIndex == index
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                      color: _selectedRoomIndex == index
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
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Icon(
                            Icons.my_library_books_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.DEFAULT_PADDING),
              const SizedBox(height: 800, child: HomeBodyWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
