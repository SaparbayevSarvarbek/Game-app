class ScoreModel{
  List<int> results=[];

  void addScore(int result){
    results.add(result);
  }
  List<int> getAllScore(){
    return results;
  }
}