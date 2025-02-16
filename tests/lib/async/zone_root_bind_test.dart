// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:expect/async_helper.dart';
import 'package:expect/expect.dart';
import 'dart:async';

main() {
  Expect.identical(Zone.root, Zone.current);
  Zone forked = Zone.current.fork();
  var f = Zone.current.bindCallback(() {
    Expect.identical(Zone.root, Zone.current);
  });
  forked.run(() {
    f();
  });
}
