package com.javatpoint.service;

import com.javatpoint.model.Login;
import com.javatpoint.model.User;
import java.util.List;

public interface UserService {

  void register(User user);
  void update(User user);

  User validateUser(Login login);
  User getUser(int id);
  User getUser(String userName);
  User getUserByEmail(String email);
  
}
