// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Formatting can break multitests, so don't format them.
// dart format off

import "package:expect/expect.dart";

import 'dart:mirrors';

main() {
  var cls = reflectClass(List);
  Expect.throwsNoSuchMethodError(() => cls.newInstance(Symbol('empty'), [null]));

  var list = cls.newInstance(Symbol('filled'), [42, null]).reflectee;
  // Check that the list is fixed.
  Expect.equals(42, list.length);
  Expect.throwsUnsupportedError(() => list.add(2));
  list[0] = 1;
  Expect.equals(1, list[0]);

  testGrowableList(); //# 01: ok
}

testGrowableList() {
  var cls = reflectClass(List);
  var list = cls.newInstance(Symbol('empty'), [], const {Symbol('growable'): true}).reflectee;
  // Check that the list is growable.
  Expect.equals(0, list.length);
  list.add(42);
  Expect.equals(1, list.length);
}
