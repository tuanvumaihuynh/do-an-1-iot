import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/models/user_model.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:do_an_1_iot/services/realtime_database_service.dart';
import 'package:do_an_1_iot/ui/screens/profile/sections/body_profile.dart';
import 'package:do_an_1_iot/ui/screens/profile/sections/header_profile.dart';
import 'package:do_an_1_iot/utils/id/id_generator.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderProfile(),
              const SizedBox(height: AppSizes.defaultPadding * 2),
              const BodyProfile(),

              ///
              ///
              ///
              /// Just for testing
              ///
              ///
              ///
              ElevatedButton(
                  onPressed: () async {
                    await AuthService.signOut();
                    await AppNavigator.replaceWith(Routes.signIn);
                  },
                  child: const Text('Sign out')),
              ElevatedButton(
                  onPressed: () async {
                    final result = await RealtimeDatabaseService.readData(
                        'users/xZuXcwHl2mduyNGxsHxjGrPbpQ33');

                    final userModel = UserModel.fromDatabase(
                        'xZuXcwHl2mduyNGxsHxjGrPbpQ33', result);

                    print(userModel.toJson());
                  },
                  child: Text('Fetch')),
              ElevatedButton(
                  onPressed: () async {
                    await RealtimeDatabaseService.updateData(
                        'users/xZuXcwHl2mduyNGxsHxjGrPbpQ33/home_list', {
                      IDGenerator.timeBasedID: {
                        'name': 'nha cua vu',
                        'room_list': {
                          'id_room1': {
                            'name': 'phong khach',
                            'device_list': {
                              '1dwq': {
                                'name': 'Khoa cua thong minh',
                                'is_locked': false,
                                'type': 'door_lock',
                              },
                              '2asd': {
                                'name': 'Quat than',
                                'is_on': false,
                                'type': 'fan',
                              },
                              '3asd': {
                                'name': 'Den than',
                                'is_on': true,
                                'type': 'light',
                              },
                            },
                          },
                          'id_room2': {
                            'name': 'phong khach 2',
                            'device_list': {
                              '4': {
                                'name': 'Khoa cua ngu',
                                'is_locked': true,
                                'type': 'door_lock',
                              },
                            },
                          }
                        }
                      },
                      'x9178': {'name': 'Nha tao', 'room_list': ''}
                    });
                  },
                  child: Text('Create home')),
            ],
          ),
        ),
      ),
    );
  }
}
