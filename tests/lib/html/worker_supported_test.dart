// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library worker_test;

import 'package:expect/legacy/minitest.dart'; // ignore: deprecated_member_use_from_same_package
import 'dart:html';

main() {
  test('supported', () {
    expect(Worker.supported, isTrue);
  });
}
