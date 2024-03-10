import 'package:easy_lib/config/test_device.dart';
import 'package:easy_lib/service/provider/provider_manager.dart';

Future<void> initAsync() async{

}
void initMustBeforeRunApp(){
  ProviderManager.init();
  TestDeviceCollection.init();
}