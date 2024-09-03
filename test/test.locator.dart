// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluorflow/fluorflow.dart' as _i2;
import 'package:mockito/annotations.dart' as _i3;

import 'test.locator.mocks.dart' as _i1;

_i1.MockNavigationService getMockNavigationService() {
  if (_i2.locator.isRegistered<_i2.NavigationService>()) {
    _i2.locator.unregister<_i2.NavigationService>();
  }
  final service = _i1.MockNavigationService();
  _i2.locator.registerSingleton<_i2.NavigationService>(service);
  return service;
}

@_i3.GenerateNiceMocks([
  _i3.MockSpec<_i2.NavigationService>(
      onMissingStub: _i3.OnMissingStub.returnDefault)
])
void setupTestLocator() {
  getMockNavigationService();
}

void tearDownLocator() => _i2.locator.reset();
