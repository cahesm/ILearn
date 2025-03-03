package com.javatpoint.dao;

import com.javatpoint.model.Answer;
import com.javatpoint.model.Content;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.javatpoint.service.SecurityService;


public class AnswerDaoImpl implements AnswerDao {

  @Autowired
  JdbcTemplate jdbcTemplate;
  
  @Autowired
  SecurityService securityService;
  

  public void register(Answer a) {
            
//    String maxSeqSql = "SELECT COALESCE(MAX(seq), 0) FROM answers WHERE idQuestion = ?";
//    Integer maxSeq = jdbcTemplate.queryForObject(maxSeqSql, new Object[]{a.getIdQuestion()}, Integer.class);
//
//    // Define o próximo seq como max + 1
//    int nextSeq = (maxSeq != null) ? maxSeq + 1 : 1;  
    String sql = "insert into answers (idQuestion,answer,seq,correct) values(?,?,?,?)";

    jdbcTemplate.update(sql, new Object[] { a.getIdQuestion(), a.getAnswer(), a.getSeq(), a.getIsCorrect()? "1": "0" });
    
    
  }
    
  public void update(Answer a) {

    String sql = "update answers set answer = ? where idAnswer = ? ";

    jdbcTemplate.update(sql, new Object[] { a.getAnswer(), a.getIdAnswer()});
        
  }
  
  public void delete(Answer a) {

    String sql = "delete from answers  where idAnswer = ? ";

    jdbcTemplate.update(sql, new Object[] {  a.getIdAnswer()});
        
  }
  
  
  public Answer getAnswer(int id) {

    String sql = "select * from answers where idAnswer = ?"; 
        
    List<Answer> answers = jdbcTemplate.query(sql, new AnswerMapper(), new Object[]{id});
        
    return !answers.isEmpty() ? answers.get(0) : null;
  }
  
  public List<Answer> getAnswers(int questionId) {

    String sql = "select * from answers where idQuestion = ? order by seq"; 
        
    return jdbcTemplate.query(sql, new AnswerMapper(), new Object[]{questionId});
        
    
  }
  
  
  
class AnswerMapper implements RowMapper<Answer> {

  public Answer mapRow(ResultSet rs, int arg1) throws SQLException {
    Answer a = new Answer();
    
    a.setIdAnswer(rs.getInt("idAnswer"));
    a.setIdQuestion(rs.getInt("idQuestion"));
    a.setSeq(rs.getInt("seq"));
    a.setIsCorrect(rs.getInt("correct") == 1);

    a.setAnswer(rs.getString("answer"));
                        
    return a;
  }}
}
  
  
