class AllBooksModel{
  final String bookId;
  final String bookName;
  final String bookAuthorName;
  final String bookType;
  final String bookImage;
  final String bookUrl;
  final String bookRate;
  final String des;
  final String bookPagesNumber;
  final String bookResource;


  AllBooksModel({
    required this.bookId,
    required this.bookName,
    required this.bookAuthorName,
    required this.bookType,
    required this.bookImage,
    required this.bookUrl,
    required this.bookRate,
    required this.des,
    required this.bookPagesNumber,
    required this.bookResource,
  });


  factory AllBooksModel.fromMap(Map<String, dynamic> map) {
    return AllBooksModel(
      bookAuthorName: map['bookAuthorName'] ?? '',
      bookId: map['bookId']?? '',
      bookImage: map['bookImage']?? '',
      bookType: map['bookType']?? '',
      bookName: map['bookName']?? '',
      bookUrl: map['bookUrl']?? '',
      bookRate: map['bookRate']?? '',
      des: map['des']?? '',
      bookResource: map['bookResource']?? '',
      bookPagesNumber: map['bookPagesNumber']?? '',
    );
  }
}