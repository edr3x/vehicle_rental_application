import 'package:rental_system_app/api/models/booking/book_vehicle_model.dart';
import 'package:rental_system_app/api/services/booking_services.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';
import 'package:rental_system_app/excepitions/data_exception.dart';

class BookingRepository {
  final BookVehicleService bookVehicleService;

  BookingRepository({
    required this.bookVehicleService,
  });

  Future<BookVehicleModel> bookVehicle({
    required String vehicleId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final BookVehicleModel bookVehicle = await bookVehicleService.data(
        vehicleId: vehicleId,
        startDate: startDate,
        endDate: endDate,
      );

      return bookVehicle;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
