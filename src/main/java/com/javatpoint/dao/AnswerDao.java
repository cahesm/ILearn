package com.javatpoint.dao;

import com.javatpoint.model.Answer;
import java.util.List;

public interface AnswerDao {

  void register(Answer answer);  
  void update(Answer answer);
  void delete(Answer answer);

  
  Answer getAnswer(int id);
  List<Answer> getAnswers(int questionId);
  
}
