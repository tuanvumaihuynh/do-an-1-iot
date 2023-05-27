import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/models/device_model.dart';
import 'package:do_an_1_iot/models/weather_model.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/providers/weather_provider.dart';

import 'package:do_an_1_iot/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/images.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherModel =
        Provider.of<WeatherProvider>(context).weatherModel;

    final selectedRoom = Provider.of<DataProvider>(context).selectedRoom;

    AirConditioner? airConditioner;
    if (selectedRoom?.devices != null) {
      for (var device in selectedRoom!.devices!) {
        if (device.runtimeType == AirConditioner) {
          airConditioner = device as AirConditioner;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weatherModel != null
                            ? '${weatherModel.temperature.toString()}°C'
                            : 'No data',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        getCurrentFormattedDate(),
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Image(
                    image: DateTime.now().hour >= 18
                        ? AppImages.nightIcon
                        : AppImages.sunIcon,
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Indoor temp',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${airConditioner?.temperature}°C',
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Humidity',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${airConditioner?.humidity}%',
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Air quality',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Good',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
