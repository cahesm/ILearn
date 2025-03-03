package com.javatpoint.dao;

import com.javatpoint.model.Content;
import java.util.List;

public interface ContentDao {

  void register(Content content);  
  void update(Content content);
  void delete(Content content);

  
  Content getContent(int id);
  List<Content> getContents(int classId);
  
}
