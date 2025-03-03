package com.javatpoint.dao;

import com.javatpoint.model.Faq;
import com.javatpoint.model.Search;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class FaqDaoImpl implements FaqDao {
  
  @Autowired
  JdbcTemplate jdbcTemplate;
    
  
  public void register( Faq faq ) {

    String sql = "insert into faq ( question, answer ) values(?,?)";

    jdbcTemplate.update(sql, new Object[] { faq.getQuestion(),faq.getAnswer()});        
  }
  
  public void update( Faq faq ) {

    String sql = "update faq set question = ?, answer = ? where  idFaq = ?  ";

    jdbcTemplate.update(sql, new Object[] { faq.getQuestion(),faq.getAnswer(),faq.getIdFaq() });
          
  }
            
  public void delete( int idFaq ) {
      
      String sql = "delete from faq where idFaq = ? ";

      jdbcTemplate.update(sql, new Object[] { idFaq });
  }
  
  public Faq getFaq( int idFaq) {

    String sql = "select * from faq where idFaq=" + idFaq ; 
        
    List<Faq> faqs = jdbcTemplate.query(sql, new FaqMapper());
        
    return faqs.size() > 0 ? faqs.get(0) : null;
  }
  
  public List<Faq> getFaqs() {

    String sql = "select * from faq " ; 
        
    List<Faq> faqs = jdbcTemplate.query(sql, new FaqMapper());
        
    return faqs;
  }
  
  public List<Faq> getFaqs( Search filter ) {

    String countSQL = "select count(*) from faq f ";
    //String orderBy = " order by f.name ";
      
      
      int count = jdbcTemplate.queryForObject( countSQL, Integer.class);  
      int pages = (int)((count + filter.getPageSize() - 1) / filter.getPageSize());
     
      int page = filter.getPage();
      
      if ( page > pages || page < 1 )
      {
          page = 1;
      }
      
      filter.setPages( pages );
      filter.setPage( page );
      filter.setTotal( count );
      
      int offset = (page - 1) * filter.getPageSize();
      
      String fullSQL = "select * from faq q limit " + offset + "," + filter.getPageSize();
        
    List<Faq> faqs = jdbcTemplate.query( fullSQL, new FaqMapper());
        
    return faqs;  
          
  }
  
  
      
}

class FaqMapper implements RowMapper<Faq> {

  public Faq mapRow(ResultSet rs, int arg1) throws SQLException {
    Faq option = new Faq();
            
    option.setIdFaq( rs.getInt("idFaq") );
    option.setQuestion( rs.getString("question"));    
    option.setAnswer(rs.getString("answer"));
        
    return option;
  }
}
  
  
  
