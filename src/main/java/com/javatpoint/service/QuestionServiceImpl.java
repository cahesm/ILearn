package com.javatpoint.service;

import com.javatpoint.dao.QuestionDao;
import com.javatpoint.model.Question;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class QuestionServiceImpl implements QuestionService {

  @Autowired
  public QuestionDao questionDao;

  public void register(Question question) {
    questionDao.register(question);
  }
  
  public void update(Question question) {
    questionDao.update(question);
  }
  
  public void delete(Question question) {
    questionDao.delete(question);
  }

  
  public Question getQuestion(int id) {
    return questionDao.getQuestion(id);
  }
  
  public List<Question> getQuestions(int classId) {
    return questionDao.getQuestions(classId);
  }
      
}
