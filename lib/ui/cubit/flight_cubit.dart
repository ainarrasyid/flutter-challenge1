import 'package:bloc/bloc.dart';
import 'package:challenge1/core/data/datasource/api/flight_api.dart';
import 'package:challenge1/core/data/model/flight/flight.dart';
import 'package:challenge1/core/utils/status.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as developer;

part 'flight_state.dart';

@injectable
class FlightCubit extends Cubit<FlightState> {
  FlightCubit(this._api) : super(FlightInitial());

  List<Flight>? listFlight;
  List<Flight>? filteredList;

  final FlightApi _api;

  void getFlightList() async {
    emit(const GetFlightState(status: Status.loading));
    try {
      final response = await _api.getFlight();
      listFlight = response.data;
      emit(GetFlightState(status: Status.success, data: response.data));
    } catch (e) {
      developer.log(e.toString());
      emit(GetFlightState(status: Status.error, message: e.toString()));
    }
  }

  void filterData(String query){
    emit(const GetFlightState(status: Status.loading));
    List<Flight> result = [];
    if(query.isEmpty && listFlight == null){
      result = listFlight!;
    }else{
      result = listFlight!
        .where((flight) =>
        flight.countryName!.toLowerCase().contains(query.toLowerCase()) ||
        flight.airportName!.toLowerCase().contains(query.toLowerCase()) ||
        flight.locationName!.toLowerCase().contains(query.toLowerCase()) 
      ).toList();
    }
    emit(GetFlightState(status: Status.success, data: result));
  }


}
