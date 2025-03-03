package com.javatpoint.service;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import com.javatpoint.dao.MediaDao;
import com.javatpoint.model.Media;

public class MediaServiceImpl implements MediaService {

  @Autowired
  public MediaDao mediaDao;

  public void register(Media media) {
    mediaDao.register(media);
  }
  
  public void update(Media media) {
    mediaDao.update(media);
  }
      
  public void delete(int id) {
    mediaDao.delete(id);
  }
  
  public void deleteAll(int type, int idSource) {
    mediaDao.deleteAll(type,idSource);
  }
      
  public Media getMedia(int id) {
    return mediaDao.getMedia(id);
  }
  
  public List<Media> getMedias( int type, int idSource ) {
    return mediaDao.getMedias( type, idSource );
  }
  
  
}
