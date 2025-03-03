package com.javatpoint.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.javatpoint.dao.UserDao;
import com.javatpoint.model.Login;
import com.javatpoint.model.User;
import java.util.List;

public class UserServiceImpl implements UserService {

  @Autowired
  public UserDao userDao;

  public void register(User user) {
    userDao.register(user);
  }
  
  public void update(User user) {
    userDao.update(user);
  }

  public User validateUser(Login login) {
    return userDao.validateUser(login);
  }
  
  public User getUser(int id) {
    return userDao.getUser(id);
  }
  
  public User getUser(String userName) {
    return userDao.getUser(userName);
  }
  
  public User getUserByEmail(String email) {
    return userDao.getUserByEmail(email);
  }
  
  
}
