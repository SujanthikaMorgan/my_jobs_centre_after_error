import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '10.0.2.2',
      user = 'ragav',
      password = 'Mathy@085',
      db = 'myjobscentertest1';
  static int port = 3308;
  // static String host = '160.153.254.214',
  //     user = 'myjobsce_jobs_user',
  //     password = 'Z{s85srW;C}K',
  //     db = 'myjobsce_jobs';
  // static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
