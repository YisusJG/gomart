class NoteModel {
  final int id;
  final String description;

  NoteModel({this.id = 0,this.description = ''});

  static List<NoteModel> notes = [
    NoteModel(id: 1, description: 'Proveedor entrega menos cantidad'),
    NoteModel(id: 2, description: 'Producto dañado'),
    NoteModel(id: 3, description: 'Producto caducado o próximo a caducar'),
  ];
}