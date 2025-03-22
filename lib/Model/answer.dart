class Answer {
  int? _id;
  int? _questionId;
  String? _description;
  int? _selectedIndex;
  bool? _isCorrect;

  int? get id => _id;

  int? get questionId => _questionId;

  String? get description => _description;

  int? get selectedIndex => _selectedIndex;

  bool? get isCorrect => _isCorrect;

  Answer(
    this._id,
    this._questionId,
    this._description,
    this._selectedIndex,
    this._isCorrect
  );

  Answer addAnswer(Answer answer) {
    return Answer(answer._id, answer._questionId, answer._description,
        answer._selectedIndex, answer._isCorrect);
  }

  Answer updateAnswer(Answer answer) {
    _id = answer._id;
    _questionId = answer._questionId;
    _description = answer._description;
    _selectedIndex = answer._selectedIndex;
    _isCorrect = answer._isCorrect;
    return this;
  }

  updateSelectedIndex(int index) {
    _selectedIndex = index;
  }


}
