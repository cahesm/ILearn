package com.javatpoint.service;

import com.javatpoint.dao.AnswerDao;
import com.javatpoint.model.Answer;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class AnswerServiceImpl implements AnswerService {

  @Autowired
  public AnswerDao answerDao;

  public void register(Answer answer) {
    answerDao.register(answer);
  }
  
  public void update(Answer answer) {
    answerDao.update(answer);
  }
  
  public void delete(Answer answer) {
    answerDao.delete(answer);
  }

  
  public Answer getAnswer(int id) {
    return answerDao.getAnswer(id);
  }
  
  public List<Answer> getAnswers(int questionId) {
    return answerDao.getAnswers(questionId);
  }
      
}
