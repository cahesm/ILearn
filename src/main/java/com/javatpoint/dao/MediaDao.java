package com.javatpoint.dao;

import com.javatpoint.model.Media;
import java.util.List;

public interface MediaDao {

  void register(Media media);  
  void update(Media media);  
  
  void delete( int id );
  void deleteAll( int type, int idSource );
  
  Media getMedia( int id );
  List<Media> getMedias( int type, int idSource );
  
}
