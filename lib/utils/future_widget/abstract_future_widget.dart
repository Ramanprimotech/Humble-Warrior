import 'package:flutter/material.dart';

abstract class FutureAPI<T> {
  Widget waiting();

  Widget success({T? data});

  Widget error({Object? error});
}
