import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/core/services/http/taskmanager.dart';

final taskService = Provider.autoDispose((ref) => TaskOption(ref));

final isloading = StateProvider((ref) => false);
