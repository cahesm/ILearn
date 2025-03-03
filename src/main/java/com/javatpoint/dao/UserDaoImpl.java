package com.javatpoint.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.javatpoint.model.Login;

import com.javatpoint.model.User;
import com.javatpoint.service.MediaService;
import com.javatpoint.service.SecurityService;
import java.util.Date;
import java.util.UUID;
import org.apache.commons.lang.RandomStringUtils;


public class UserDaoImpl implements UserDao {

  @Autowired
  JdbcTemplate jdbcTemplate;
  
  @Autowired
  SecurityService securityService;
  

  public void register(User user) {
            
    String sql = "insert into users (username,password,name,email,phone,creation, verificationToken) values(?,?,?,?,?,?,?)";

    jdbcTemplate.update(sql, new Object[] { user.getUsername(), user.getPassword(), user.getName(),
       user.getEmail(), user.getPhone(), new Date(), UUID.randomUUID().toString() });
    
    
  }
    
  public void update(User user) {

    String sql = "update users set password = ?, name = ?, email = ?, phone = ? where username = ? ";

    jdbcTemplate.update(sql, new Object[] { user.getPassword(), user.getName(),
       user.getEmail(), user.getPhone(), user.getUsername() });
        
  }
  
  public User validateUser(Login login) {

    String pass = securityService.encrypt( login.getPassword() );
            
    String sql = "select * from users where ( username='" + login.getUsername() + "' or email='"+login.getUsername()+"') and password='" + pass + "'";

    List<User> users = jdbcTemplate.query(sql, new UserMapper());

    return users.size() > 0 ? users.get(0) : null;
  }
  
  public User getUser(int id) {

    String sql = "select * from users where idUser = ?"; 
        
    List<User> users = jdbcTemplate.query(sql, new UserMapper(), new Object[]{id});
        
    return users.size() > 0 ? users.get(0) : null;
  }
  
  public User getUser(String userName) {

    String sql = "select * from users where username='" + userName + "'"; 
        
    List<User> users = jdbcTemplate.query(sql, new UserMapper());
        
    return users.size() > 0 ? users.get(0) : null;
  }
  
  public User getUserByEmail(String email) {

    String sql = "select * from users where email='" + email + "'"; 
        
    List<User> users = jdbcTemplate.query(sql, new UserMapper());
        
    return users.size() > 0 ? users.get(0) : null;
  }
  
  
  
class UserMapper implements RowMapper<User> {

  public User mapRow(ResultSet rs, int arg1) throws SQLException {
    User user = new User();
            
    user.setIdUser( rs.getInt("idUser"));
    //user.setCod(rs.getString("cod"));
    user.setUsername(rs.getString("username"));
    user.setPassword(rs.getString("password"));
    user.setName( rs.getString("name"));    
    user.setEmail(rs.getString("email"));
    //user.setAddress(rs.getString("address"));
    user.setPhone(rs.getString("phone"));    
    user.setCreation( rs.getTimestamp("creation"));
    user.setVerificationToken(rs.getString("verificationToken"));   
    user.setActive( rs.getBoolean("active"));
                
    return user;
  }}
}
  
  
