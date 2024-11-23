import 'package:fnb_point_sale_base/serialportdevices/service/process_runner_service.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:process_run/shell.dart';

class ProcessRunnerServiceImpl with ProcessRunnerService {
  final tag = 'ProcessRunnerService';

  @override
  Future<bool> execute(String message) async {
    var shell = Shell();
    MyLogUtils.logDebug("$tag execute : $message");
    var result = await shell.run(message);
    MyLogUtils.logDebug("$tag result  :$result for command : $message");
    return true;
  }
}
