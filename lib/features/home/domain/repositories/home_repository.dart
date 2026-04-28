import '../../../../core/utils/api_result.dart';
import '../entities/dashboard_data.dart';

abstract class HomeRepository {
  Future<ApiResult<DashboardData>> getDashboardData();
}
