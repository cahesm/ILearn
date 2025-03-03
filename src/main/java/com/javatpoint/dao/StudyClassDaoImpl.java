package com.javatpoint.dao;

import com.javatpoint.model.Content;
import com.javatpoint.model.Question;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.javatpoint.model.StudyClass;
import com.javatpoint.service.ContentService;
import com.javatpoint.service.QuestionService;

import com.javatpoint.service.SecurityService;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;


public class StudyClassDaoImpl implements StudyClassDao {

  @Autowired
  JdbcTemplate jdbcTemplate;
  
  @Autowired
  SecurityService securityService;
  
  @Autowired
  ContentService contentService;
  
  @Autowired
  QuestionService questionService;
  

  public void register(StudyClass c) {
            
    String sql = "insert into classes (idUser,name, creation) values(?,?,?)";

    //jdbcTemplate.update(sql, new Object[] { c.getIdUser(), c.getName(),  });
    
    KeyHolder keyHolder = new GeneratedKeyHolder();
    	jdbcTemplate.update(
    	    new PreparedStatementCreator() {
    	        public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
    	            PreparedStatement pst =
    	                con.prepareStatement(sql, new String[] {"idUser","name","creation"});
    	            
    	            pst.setInt(1, c.getIdUser());    	                	            
    	            pst.setString(2, c.getName());    	            
    	            pst.setTimestamp(3, new Timestamp(System.currentTimeMillis()));    	            
                    
    	            return pst;
    	        }
    	    },
    	    keyHolder); 
    
    int idClass = keyHolder.getKey().intValue();
    
    int seq = 0;
    for ( Content content : c.getContents())
    {
        content.setIdClass(idClass);
        content.setSeq(seq++);
        
        contentService.register(content);
        
    }
    
    seq = 0;
    for ( Question question : c.getQuestions())
    {
        question.setIdClass(idClass);
        question.setSeq(seq++);
        
        questionService.register(question);        
    }
    
  }
    
  public void update(StudyClass c) {

    String sql = "update classes set name = ? where idUser = ? ";

    jdbcTemplate.update(sql, new Object[] { c.getName(), c.getIdUser() });
        
  }
  
  public void delete(StudyClass sc) {

    List<Content> contents = contentService.getContents(sc.getIdClass());
    
    for(Content c : contents)
    {
        contentService.delete(c);
    }
    
    List<Question> questions = questionService.getQuestions(sc.getIdClass());
    
    for(Question q : questions)
    {
        questionService.delete(q);
    }
            
    String sql = "delete from classes where idClass = ? ";

    jdbcTemplate.update(sql, new Object[] { sc.getIdClass() });
        
  }
  
  
  public StudyClass getStudyClass(int id) {

    String sql = "select * from classes where idClass = ?"; 
        
    List<StudyClass> classes = jdbcTemplate.query(sql, new StudyClassMapper( true), new Object[]{id});
        
    return !classes.isEmpty() ? classes.get(0) : null;
  }
  
  public List<StudyClass> getStudyClasses(int userId) {

    String sql = "select * from classes where idUser = ?"; 
        
    return jdbcTemplate.query(sql, new StudyClassMapper(), new Object[]{userId});
        
    
  }
  
  
  
class StudyClassMapper implements RowMapper<StudyClass> {

  private boolean loadAll = false;

  public StudyClassMapper()
  {
      
  }
  
  public StudyClassMapper( boolean loadAll)
  {
      this.loadAll = loadAll;
  }
    
  public StudyClass mapRow(ResultSet rs, int arg1) throws SQLException {
    StudyClass c = new StudyClass();
            
    c.setIdClass(rs.getInt("idClass"));
    c.setIdUser(rs.getInt("idUser"));

    c.setName(rs.getString("name"));
    c.setCreation(rs.getTimestamp("creation"));
    
    if ( loadAll )
        {            
            c.setContents( contentService.getContents(c.getIdClass()));
            
            c.setQuestions( questionService.getQuestions(c.getIdClass()));
            
        }
    
                
    return c;
  }}
}
  
  
