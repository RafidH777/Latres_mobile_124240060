import 'package:flutter_test/flutter_test.dart';
import 'package:latres/models/show_model.dart';

void main() {
  test('ShowModel fromJson parsing test', () {
    final sampleJson = {
      'id': 1,
      'name': 'Under the Dome',
      'genres': ['Drama', 'Science-Fiction'],
      'rating': {'average': 6.5},
      'image': {
        'medium': 'https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg',
      },
      'summary': '<p><b>Under the Dome</b> is a drama series.</p>',
    };

    final show = ShowModel.fromJson(sampleJson);
    expect(show.id, 1);
    expect(show.name, 'Under the Dome');
    expect(show.rating, 6.5);
    expect(show.genres, ['Drama', 'Science-Fiction']);
    expect(show.summary, 'Under the Dome is a drama series.');
  });
}
