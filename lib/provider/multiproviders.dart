import 'package:enam_dua_teknologi/provider/business/business.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> multiProvider = [
  ChangeNotifierProvider(create: (_) => ProviderBusiness()),
];
