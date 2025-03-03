package com.javatpoint.dao;

import com.javatpoint.model.Answer;
import com.javatpoint.model.Question;
import com.javatpoint.service.AnswerService;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.javatpoint.service.SecurityService;
import java.sql.Connection;
import java.sql.PreparedStatement;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;


public class QuestionDaoImpl implements QuestionDao {

  @Autowired
  JdbcTemplate jdbcTemplate;
  
  @Autowired
  SecurityService securityService;
  
  @Autowired
  AnswerService answerService;
  

  public void register(Question q) {
            
    //String maxSeqSql = "SELECT COALESCE(MAX(seq), 0) FROM questions WHERE idClass = ?";
    //Integer maxSeq = jdbcTemplate.queryForObject(maxSeqSql, new Object[]{q.getIdClass()}, Integer.class);

    // Define o próximo seq como max + 1
    //int nextSeq = (maxSeq != null) ? maxSeq + 1 : 1;  
    String sql = "insert into questions (idClass,question,answer,seq) values(?,?,?,?)";

    KeyHolder keyHolder = new GeneratedKeyHolder();
    	jdbcTemplate.update(
    	    new PreparedStatementCreator() {
    	        public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
    	            PreparedStatement pst =
    	                con.prepareStatement(sql, new String[] {"idClass","question","answer","seq"});
    	            
    	            pst.setInt(1, q.getIdClass());    	                	            
    	            pst.setString(2, q.getQuestion());
                    pst.setString(3, q.getAnswer());    
    	            pst.setInt(4, q.getSeq());    	            
                    
    	            return pst;
    	        }
    	    },
    	    keyHolder); 
    
    int idQuestion = keyHolder.getKey().intValue();
    
    int seq = 0;
    for ( Answer answer : q.getAnswers())
    {
        answer.setIdQuestion(idQuestion);
        answer.setSeq(seq++);
        
        answerService.register(answer);
        
    }
    //jdbcTemplate.update(sql, new Object[] { q.getIdClass(), q.getQuestion(),q.getRightOption(), nextSeq });
    
    
  }
    
  public void update(Question q) {

    String sql = "update questions set question = ? where idQuestion = ? ";

    jdbcTemplate.update(sql, new Object[] { q.getQuestion(), q.getIdQuestion()});
        
  }
  
  public void delete(Question q) {

    List<Answer> answers = answerService.getAnswers( q.getIdQuestion());
    
    for( Answer a : answers )
    {
        answerService.delete( a );
    }
            
    String sql = "delete from questions  where idQuestion = ? ";

    jdbcTemplate.update(sql, new Object[] {  q.getIdQuestion()});
        
  }
  
  
  public Question getQuestion(int id) {

    String sql = "select * from questions where idQuestion = ?"; 
        
    List<Question> questions = jdbcTemplate.query(sql, new QuestionMapper(), new Object[]{id});
        
    return !questions.isEmpty() ? questions.get(0) : null;
  }
  
  public List<Question> getQuestions(int classId) {

    String sql = "select * from questions where idClass = ? order by seq"; 
        
    return jdbcTemplate.query(sql, new QuestionMapper(), new Object[]{classId});
        
    
  }
  
  
  
class QuestionMapper implements RowMapper<Question> {

  public Question mapRow(ResultSet rs, int arg1) throws SQLException {
    Question c = new Question();
    
    c.setIdQuestion(rs.getInt("idQuestion"));
    c.setIdClass(rs.getInt("idClass"));
    c.setSeq(rs.getInt("seq"));
    c.setRightOption(rs.getInt("rightOption"));

    c.setQuestion(rs.getString("question"));
    c.setAnswer(rs.getString("answer"));
    
    c.setAnswers( answerService.getAnswers( c.getIdQuestion()));
                        
    return c;
  }}
}
  
  
