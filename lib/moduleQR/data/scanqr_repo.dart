
import 'package:flutter/material.dart';

import 'scanqr_srv.dart';

class ScanqrRepo {
  ScanqrSrv _scanqrSrv;
  ScanqrRepo({@required ScanqrSrv scanqrSrv}) : _scanqrSrv = scanqrSrv;
}
