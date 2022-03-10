// Copyright 2018 DebuggerX <dx8917312@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

var preview_server_port = 2227;

void main() async {
  bool working = false;
  var pubSpec = new File('pubspec.yaml');
  var pubLines = pubSpec.readAsLinesSync();
  var newLines = <String>[];
  var resource = <String>[];
  for (var line in pubLines) {
    if (line.contains('begin') && line.contains('#') && line.contains('assets')) {
      working = true;
      newLines.add(line);
    }
    if (line.contains('end') && line.contains('#') && line.contains('assets')) working = false;

    if (working) {
      if (line.trim().startsWith('#') && line.trim().endsWith('*')) {
        newLines.add(line);
        var directory = new Directory(line.replaceAll('#', '').replaceAll('*', '').trim());
        if (directory.existsSync()) {
          var list = directory.listSync(recursive: true);
          for (var file in list) {
            if (new File(file.path)
                .statSync()
                .type == FileSystemEntityType.file) {
              var path = file.path.replaceAll('\\', '/');
              var varName = path.substring(path.lastIndexOf("/") + 1).toLowerCase();
              if(varName.startsWith("."))continue;
              varName = varName.substring(0,varName.lastIndexOf("."));
              var pos = 0;
              String char;
              while (true) {
                pos = varName.indexOf('_', pos);
                if (pos == -1) break;
                char = varName.substring(pos + 1, pos + 2);
                varName = varName.replaceFirst('_$char', '_${char.toUpperCase()}');
                pos++;
              }
              varName = varName.replaceAll('_', '');
              // resource.add("/// ![](http://127.0.0.1:$preview_server_port/$path)");
              resource.add("static const String $varName = '$path';");
              newLines.add('    - $path');
            }
          }
        } else {
          throw new FileSystemException('Directory wrong');
        }
      }
    } else {
      newLines.add(line);
    }
  }

  var r = new File('lib/r.dart');
  if (r.existsSync()) {
    r.deleteSync();
  }
  r.createSync();
  var content = 'class R {\n';
  for (var line in resource) {
    content = '$content  $line\n';
  }
  content = '$content}\n';
  r.writeAsStringSync(content);

  var spec = '';
  for (var line in newLines) {
    spec = '$spec$line\n';
  }
  pubSpec.writeAsStringSync(spec);

  // var ser;
  // try {
  //   ser = await HttpServer.bind('127.0.0.1', preview_server_port);
  //   print('Service started successfully<$preview_server_port> port');
  //   ser.listen(
  //         (req) {
  //       var index = req.uri.path.lastIndexOf('.');
  //       var subType = req.uri.path.substring(index);
  //       req.response
  //         ..headers.contentType = new ContentType('image', subType)
  //         ..add(new File('.${req.uri.path}').readAsBytesSync())
  //         ..close();
  //     },
  //   );
  // } catch (e) {
  //   print('Service started or port occupied');
  // }
}