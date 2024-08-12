




import 'package:cross_player/src/enum/data_source_type.dart';

class DataSource{
  final String source;
  final String? mimeType;
  final DataSourceType sourceType;
  const DataSource({
    required this.source,
    required this.sourceType,
    this.mimeType
  });
  const DataSource.network(this.source,{this.mimeType})
      : sourceType = DataSourceType.network;
  const DataSource.asset(this.source,{this.mimeType})
      : sourceType = DataSourceType.asset;
  const DataSource.file(this.source,{this.mimeType})
      : sourceType = DataSourceType.file;
}