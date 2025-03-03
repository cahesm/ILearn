package com.javatpoint.dao;

import com.javatpoint.model.Question;
import java.util.List;

public interface QuestionDao {

  void register(Question question);  
  void update(Question question);
  void delete(Question question);

  
  Question getQuestion(int id);
  List<Question> getQuestions(int classId);
  
}
