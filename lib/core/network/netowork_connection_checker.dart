abstract class NetworkConnectionChecker {
  Future<bool> isConnected();
  Stream<bool> connectionStream();
}
