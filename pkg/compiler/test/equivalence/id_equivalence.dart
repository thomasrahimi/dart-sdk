// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_fe_analyzer_shared/src/testing/id.dart';
import 'package:compiler/src/common.dart';
import 'package:compiler/src/ir/util.dart';
import 'package:compiler/src/js_model/locals.dart';
import 'package:expect/expect.dart';
import 'package:kernel/ast.dart' as ir;
import 'package:front_end/src/api_prototype/testing.dart';

export 'package:_fe_analyzer_shared/src/testing/id.dart';
export 'package:front_end/src/api_prototype/testing.dart'
    show computeMemberId, computeTreeNodeWithOffset;

SourceSpan computeSourceSpanFromUriOffset(Uri uri, int offset) {
  return offset != -1
      ? SourceSpan(uri, offset, offset + 1)
      : SourceSpan(uri, 0, 0);
}

mixin IrDataRegistryMixin<T> implements DataRegistry<T> {
  DiagnosticReporter get reporter;

  @override
  void report(Uri uri, int offset, String message) {
    reportHere(reporter, computeSourceSpanFromUriOffset(uri, offset), message);
  }

  @override
  void fail(String message) {
    Expect.fail(message);
  }
}

abstract class IrDataExtractor<T> extends DataExtractor<T>
    with IrDataRegistryMixin<T> {
  @override
  final DiagnosticReporter reporter;

  IrDataExtractor(this.reporter, Map<Id, ActualData<T>> actualMap)
    : super(actualMap);

  SourceSpan computeSourceSpan(ir.TreeNode node) {
    return computeSourceSpanFromTreeNode(node);
  }

  @override
  visitLabeledStatement(ir.LabeledStatement node) {
    if (!JumpVisitor.canBeBreakTarget(node.body) &&
        !JumpVisitor.canBeContinueTarget(node.parent!)) {
      computeForNode(node, createLabeledStatementId(node));
    }
    super.visitLabeledStatement(node);
  }
}

/// Print a message with a source location.
void reportHere(
  DiagnosticReporter reporter,
  Spannable node,
  String debugMessage,
) {
  reporter.reportInfoMessage(node, MessageKind.generic, {
    'text': 'HERE: $debugMessage',
  });
}
