import 'dart:io';

import 'package:challenge1/core/data/model/flight/flight.dart';
import 'package:challenge1/core/utils/status.dart';
import 'package:challenge1/core/utils/theme_extension.dart';
import 'package:challenge1/core/widgets/app_button.dart';
import 'package:challenge1/core/widgets/app_colors.dart';
import 'package:challenge1/core/widgets/app_search_bar.dart';
import 'package:challenge1/ui/cubit/flight_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Widget headerSection() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        color: Colors.blue,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: AppSearchBar(
                hint: "Search airport or city name",
                onChanged: (query) => context.read<FlightCubit>().filterData(query),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: AppButton(
                caption: "CLOSE",
                onPressed: () => exit(0),
                color: Colors.blue,
                padding: 13,
              ),
            )
          ],
        ),
      );
    }

    Widget listHeader(String value) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: AppColors.softGray),
        child: Text(
          value,
          textAlign: TextAlign.start,
          style: context.textTheme.headline6
              ?.copyWith(color: AppColors.textGray, fontSize: 14.sp),
        ),
      );
    }

    Widget itemList(String name, String location) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.headline6?.copyWith(fontSize: 14.sp),
                ),
                Text(
                  location,
                  style: context.textTheme.subtitle1
                      ?.copyWith(color: AppColors.textGray, fontSize: 12.sp),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: AppColors.softGray,
          )
        ],
      );
    }

    Widget notFound() {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restore_rounded,
                size: 100, color: AppColors.textBlack),
            Text(
              "Data not found",
              style: context.textTheme.headline6
                  ?.copyWith(color: AppColors.textBlack),
            )
          ],
        ),
      );
    }

    Widget loading() {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      );
    }

    Widget listSection() {
      return Expanded(
        child: BlocBuilder<FlightCubit, FlightState>(
          builder: (context, state) {
            if (state is GetFlightState && state.status == Status.success) {
              return GroupedListView<Flight, String>(
                elements: state.data!,
                groupBy: (element) => element.countryName!,
                itemComparator: (item1, item2) =>
                    item1.airportName!.compareTo(item2.airportName!),
                order: GroupedListOrder.ASC,
                useStickyGroupSeparators: true,
                floatingHeader: false,
                groupSeparatorBuilder: (String value) => listHeader(value),
                itemBuilder: (context, element) =>
                    itemList(element.airportName!, element.locationName!),
              );
            } else if (state is GetFlightState &&
                state.status == Status.loading) {
              return loading();
            }
            return notFound();
          },
        ),
      );
    }

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            headerSection(),
            listSection()
          ],
        )),
      ),
    );
  }
}
