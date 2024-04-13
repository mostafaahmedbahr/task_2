class AllBooksModel{
  final String bookId;
  final String bookName;
  final String bookAuthorName;
  final String bookType;
  final String bookPrice;
  final String bookImage;
  final String bookUrl;
  final String bookRate;
  final String des;


  AllBooksModel({
    required this.bookId,
    required this.bookName,
    required this.bookAuthorName,
    required this.bookType,
    required this.bookImage,
    required this.bookPrice,
    required this.bookUrl,
    required this.bookRate,
    required this.des,
  });


  factory AllBooksModel.fromMap(Map<String, dynamic> map) {
    return AllBooksModel(
      bookAuthorName: map['bookAuthorName'] ?? '',
      bookId: map['bookId']?? '',
      bookImage: map['bookImage']?? '',
      bookType: map['bookType']?? '',
      bookPrice: map['bookPrice']?? '',
      bookName: map['bookName']?? '',
      bookUrl: map['bookUrl']?? '',
      bookRate: map['bookRate']?? '',
      des: map['des']?? '',
    );
  }
}