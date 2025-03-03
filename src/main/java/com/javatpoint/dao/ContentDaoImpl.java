package com.javatpoint.dao;

import com.javatpoint.model.Content;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.javatpoint.model.StudyClass;

import com.javatpoint.service.SecurityService;


public class ContentDaoImpl implements ContentDao {

  @Autowired
  JdbcTemplate jdbcTemplate;
  
  @Autowired
  SecurityService securityService;
  

  public void register(Content c) {
            
    String maxSeqSql = "SELECT COALESCE(MAX(seq), 0) FROM contents WHERE idClass = ?";
    Integer maxSeq = jdbcTemplate.queryForObject(maxSeqSql, new Object[]{c.getIdClass()}, Integer.class);

    // Define o próximo seq como max + 1
    int nextSeq = (maxSeq != null) ? maxSeq + 1 : 1;  
    String sql = "insert into contents (idClass,content,seq) values(?,?,?)";

    jdbcTemplate.update(sql, new Object[] { c.getIdClass(), c.getContent(), nextSeq });
    
    
  }
    
  public void update(Content c) {

    String sql = "update contents set content = ? where idContent = ? ";

    jdbcTemplate.update(sql, new Object[] { c.getContent(), c.getIdContent()});
        
  }
  
  public void delete(Content c) {

    String sql = "delete from contents where idContent = ? ";

    jdbcTemplate.update(sql, new Object[] { c.getIdContent()});
        
  }
  
  
  public Content getContent(int id) {

    String sql = "select * from contents where idContent = ?"; 
        
    List<Content> contents = jdbcTemplate.query(sql, new ContentMapper(), new Object[]{id});
        
    return !contents.isEmpty() ? contents.get(0) : null;
  }
  
  public List<Content> getContents(int classId) {

    String sql = "select * from contents where idClass = ? order by seq"; 
        
    return jdbcTemplate.query(sql, new ContentMapper(), new Object[]{classId});
        
    
  }
  
  
  
class ContentMapper implements RowMapper<Content> {

  public Content mapRow(ResultSet rs, int arg1) throws SQLException {
    Content c = new Content();
    
    c.setIdContent(rs.getInt("idContent"));
    c.setIdClass(rs.getInt("idClass"));
    c.setSeq(rs.getInt("seq"));

    c.setContent(rs.getString("content"));
                        
    return c;
  }}
}
  
  
