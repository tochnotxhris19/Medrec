
// // ignore_for_file: nullable_type_in_catch_clause

// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';




// final baseServiceProvider = Provider<BaseService>((ref) {
//   return BaseService();
// });

// class BaseService {
  
//   Future<Either<Failure,T>> call<Failure,T>(Future<Either<Failure,T>> Function() call) async {
//     try {
//       return await call();
//     } on Failure catch (error) {
//       return Error(error);
//     }
//   }
// }