package com.javatpoint.dao;

import com.javatpoint.model.StudyClass;
import java.util.List;

public interface StudyClassDao {

  void register(StudyClass user);  
  void update(StudyClass user);
  void delete(StudyClass user);

  
  StudyClass getStudyClass(int id);
  List<StudyClass> getStudyClasses(int userId);
  
}
