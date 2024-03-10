import 'package:easy_lib/service/provider/page_change_provider.dart';

class ProviderManager {
  static late PageChangeProvider pageChangeProvider;
  // static late Map<String,ChangeNotifier> providerMap;
  static void init(){
    pageChangeProvider = PageChangeProvider();
  }
}