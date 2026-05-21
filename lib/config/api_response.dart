class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory ApiResponse.success(dynamic data) {
    return ApiResponse(success: true, data: data);
  }

  factory ApiResponse.error(String message) {
    return ApiResponse(success: false, message: message);
  }
}
