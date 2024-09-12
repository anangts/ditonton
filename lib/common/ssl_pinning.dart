import 'dart:io';
import 'package:flutter/services.dart';

class SSLPinningContext {
  Future<SecurityContext> get sslContext async {
    final sslCert = await rootBundle.load('assets/certs/themoviedb-org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }
}
