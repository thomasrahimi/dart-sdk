// TODO(multitest): This was automatically migrated from a multitest and may
// contain strange or dead code.

// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:expect/expect.dart';

get await => 4;

// For functions that are declared with the async modifier we treat await as
// keyword.

test0() async {
  var x = await 7;
  Expect.equals(7, x);
}

test1() async {
  var x = await 9;
  Expect.equals(9, x);
}

// For functions that are not declared with the async modifier we allow await to
// be used as an identifier.

test2() {
  var y = await;
  Expect.equals(4, y);
}

test3() {
  var await = 3;
  Expect.equals(3, await);
}

main() {
  test0();
  test1();
  test2();
  test3();
}
