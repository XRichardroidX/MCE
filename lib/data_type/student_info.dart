class StudentDetails{
  final String userName;
  final String regNumber;
  final String level;
  final String email;
  final String password;
  final String UserID;
  final String imageUrl;

  const StudentDetails({
    required String this.userName,
    required String this.regNumber,
    required String this.level,
    required String this.email,
    required String this.password,
    required String this.UserID,
    required String this.imageUrl,
  });

  Map<String, dynamic> toJson() =>
      {
        "Name": userName,
        "Reg-Number": regNumber,
        "Level": level,
        "E-mail": email,
        "Password": password,
        "UserID": UserID,
        "profileUrl": imageUrl,
      };


}