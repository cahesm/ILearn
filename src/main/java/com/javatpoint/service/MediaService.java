package com.javatpoint.service;

import com.javatpoint.model.Media;
import java.util.List;

public interface MediaService {

  void register(Media media);  
  void update(Media media);  
  void delete(int id);
  void deleteAll(int type, int idSource);
  
  Media getMedia( int idDisponibility );
  List<Media> getMedias( int type, int idSource );
    
}
