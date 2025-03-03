package com.javatpoint.service;

import com.javatpoint.model.Answer;
import java.util.List;

public interface AnswerService {

  void register(Answer answer);
  void update(Answer answer);
  void delete(Answer answer);

  
  Answer getAnswer(int id);
  List<Answer> getAnswers(int questionId);
  
  
}
