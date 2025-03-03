package com.javatpoint.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.javatpoint.model.Media;
import java.util.Date;

public class MediaDaoImpl implements MediaDao {

  @Autowired
  JdbcTemplate jdbcTemplate;
    
  public void register(Media media) {

    String sql = "insert into medias ( idSource, type, name, alias, status, creation ) values(?,?,?,?,?,?)";

    jdbcTemplate.update(sql, new Object[] { media.getIdSource(),media.getType(), media.getName(), media.getAlias(),media.getStatus(), new Date() });        
  }
  
  public void update(Media media) {

    String sql = "update medias set name = ?, alias = ?, status = ?, comment = ? where idMedia = ?  ";

    jdbcTemplate.update(sql, new Object[] { media.getName(),media.getAlias(), media.getStatus(), media.getComment(), media.getIdMedia() });
          
  }
            
  public void delete( int id ) {
      
      String sql = "delete from medias where idMedia = ? ";

      jdbcTemplate.update(sql, new Object[] { id });
  }
  
  public void deleteAll( int type, int idSource ) {
      
      String sql = "delete from medias where type = ? and idSource = ? ";

      jdbcTemplate.update(sql, new Object[] { type, idSource });
  }
  
  public Media getMedia(int idMedia) {

    String sql = "select * from medias where idMedia = " + idMedia; 
        
    List<Media> medias = jdbcTemplate.query(sql, new MediaMapper());
        
    return medias.size() > 0 ? medias.get(0) : null;
  }
  
  public List<Media> getMedias(int type, int idSource) {

    String sql = "select * from medias where type = ? and idSource = ?" ; 
        
    List<Media> medias = jdbcTemplate.query(sql, new MediaMapper(),new Object[] { type, idSource });
        
    return medias;
  }
      
}

class MediaMapper implements RowMapper<Media> {

  public Media mapRow(ResultSet rs, int arg1) throws SQLException {
    Media media = new Media();
            
    media.setIdMedia(rs.getInt("idMedia"));
    media.setIdSource( rs.getInt("idSource"));
    media.setType(rs.getInt("type"));
    media.setName( rs.getString("name"));
    media.setComment( rs.getString("comment"));
    media.setAlias( rs.getString("alias"));
    media.setStatus( rs.getInt("status"));
    media.setCreation( rs.getTimestamp("creation"));
        
    return media;
  }}
  
  
