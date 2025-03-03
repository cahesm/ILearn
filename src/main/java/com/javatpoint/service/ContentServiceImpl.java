package com.javatpoint.service;

import com.javatpoint.dao.ContentDao;
import com.javatpoint.dao.StudyClassDao;
import com.javatpoint.model.Content;
import org.springframework.beans.factory.annotation.Autowired;

import com.javatpoint.model.StudyClass;
import java.util.List;

public class ContentServiceImpl implements ContentService {

  @Autowired
  public ContentDao contentDao;

  public void register(Content content) {
    contentDao.register(content);
  }
  
  public void update(Content content) {
    contentDao.update(content);
  }
  
  public void delete(Content content) {
    contentDao.delete(content);
  }

  
  public Content getContent(int id) {
    return contentDao.getContent(id);
  }
  
  public List<Content> getContents(int classId) {
    return contentDao.getContents(classId);
  }
      
}
