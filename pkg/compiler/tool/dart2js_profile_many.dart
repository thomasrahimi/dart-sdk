// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library;

import 'dart:async';

import 'package:compiler/src/dart2js.dart' as cmdline;

const String usage = """
Usage: dart2js_profile_many.dart [OPTIONS] [FILES]

Invokes dart2js separately for each file using the given options.
This is for profiling multiple compilations in the Dart Observatory.
""";

void printUsage() {
  print(usage);
}

void main(List<String> args) {
  var options = <String>[];
  var files = <String>[];

  for (String arg in args) {
    if (arg.startsWith('-')) {
      options.add(arg);
    } else {
      files.add(arg);
    }
  }

  if (files.isEmpty) {
    printUsage();
    return;
  }

  cmdline.exitFunc = (code) {
    throw "Exit with code $code";
  };

  Future.forEach(files, (String file) {
    List<String> subargs = [];
    subargs.addAll(options);
    subargs.add(file);
    return cmdline.compilerMain(subargs);
  }).then((_) {
    print("Done");
  });
}
