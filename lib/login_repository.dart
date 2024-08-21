abstract class LoginRepository {
  Future<bool> login({required String? email, required String? password});
}
