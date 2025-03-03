package com.javatpoint.service;

import com.javatpoint.dao.StudyClassDao;
import org.springframework.beans.factory.annotation.Autowired;

import com.javatpoint.model.StudyClass;
import com.javatpoint.model.User;
import java.util.List;

public class StudyClassServiceImpl implements StudyClassService {

  @Autowired
  public StudyClassDao classDao;

  public void register(StudyClass studyClass) {
    classDao.register(studyClass);    
  }
  
  public void update(StudyClass studyClass) {
    classDao.update(studyClass);
  }
  
  public void delete(StudyClass studyClass) {
    classDao.delete(studyClass);
  }

  
  public StudyClass getStudyClass(int id) {
    return classDao.getStudyClass(id);
  }
  
  public List<StudyClass> getStudyClasses(int userId) {
    return classDao.getStudyClasses(userId);
  }
      
}
