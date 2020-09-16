import 'package:equatable/equatable.dart';

class Photos extends Equatable {
  final int id;
  final String original;
  Photos({
    this.id,
    this.original,
  });
  @override
  List<Object> get props => [id, original];

  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: map['id'],
      original: map['src']['original'],
    );
  }

  @override
  String toString() => 'Photos { id: $id, original: $original }';
}
