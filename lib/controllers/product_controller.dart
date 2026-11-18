import 'package:get/get.dart';
import '../models/show_model.dart';
import '../services/api_services.dart';

class ProductController extends GetxController {
  final RxList<ShowModel> shows = <ShowModel>[].obs;
  final RxList<ShowModel> filteredShows = <ShowModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  // Fetch all TV shows from API
  Future<void> fetchShows() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await ApiService.getShows();
      shows.assignAll(result);
      filteredShows.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Filter shows by search query
  void filterShows(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      filteredShows.assignAll(shows);
    } else {
      filteredShows.assignAll(
        shows.where((show) => show.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}

// Alias for semantic clarity
typedef ShowController = ProductController;
