package com.javatpoint.service;

import com.javatpoint.model.Question;
import java.util.List;

public interface QuestionService {

  void register(Question question);
  void update(Question question);
  void delete(Question question);

  
  Question getQuestion(int id);
  List<Question> getQuestions(int classId);
  
  
}
