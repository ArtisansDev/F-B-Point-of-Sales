
mixin RakyetBankTerminalService {
  void requestPaymentAsync(double amount, Function onProcessCompleted);

  Future<bool> echoTerminalTest();

  Future<bool> initDevice();

  Future<bool> closeThePort();
}