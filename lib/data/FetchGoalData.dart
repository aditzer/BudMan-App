import '../models/Goal.dart';
import '../models/User.dart';
import 'FetchData.dart';

class FetchGoalData{
  static Future<List<List<Goal>>> goalData() async {
    User user= await FetchData.fetchStoredData();
    List<List<Goal>> data=[[],[],[]];

    for(int i=0;i<user.goals.length;i++){
      Goal goal=user.goals[i];
      if(goal.goalStatus=='active'){
        data[0].add(goal);
      }
      else if(goal.goalStatus=='paused'){
        data[1].add(goal);
      }
      else if(goal.goalStatus=='completed'){
        data[2].add(goal);
      }
    }
    return data;
  }
}