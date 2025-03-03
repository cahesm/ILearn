package com.javatpoint.service;

import com.javatpoint.model.StudyClass;
import java.util.List;

public interface StudyClassService {

  void register(StudyClass studyClass);
  void update(StudyClass studyClass);
  void delete(StudyClass studyClass);

  
  StudyClass getStudyClass(int id);
  List<StudyClass> getStudyClasses(int userId);
  
  
}
