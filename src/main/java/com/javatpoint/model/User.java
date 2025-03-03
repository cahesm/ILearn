package com.javatpoint.model;

import java.sql.Timestamp;
import javax.validation.constraints.Size;

public class User {

    
  @Size(min = 2, max = 16)  
  private String username;
  
  //private String cod;
  private String password;
  private String confirmPassword;
  private String name;  
  private String email;
  private String verificationToken;
  
  private int idUser;
  
  private String phone;
  
  private Timestamp creation;
    
  private boolean active = false;
  
  
//  /**
//   * @return String
//   */
//  public String getCod()
//  {
//      return cod;
//  }
//  
//  /**
//   * @param cod String
//   */
//  public void setCod( String value )
//  {
//      this.cod = value;
//  }
//  

  
  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {    
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  
  /**
   * @return String
   */
  public String getConfirmPassword()
  {
      return confirmPassword;
  }
  
  /**
   * @param confirmPassword String
   */
  public void setConfirmPassword( String value )
  {
      this.confirmPassword = value;
  }
  

  /**
   * @return String
   */
  public String getName()
  {
      return name;
  }
  
  /**
   * @param name String
   */
  public void setName( String value )
  {
      this.name = value;
  }
  
  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }
  
  
  /**
   * @return String
   */
  public String getPhone()
  {
      return phone;
  }
  
  /**
   * @param phone String
   */
  public void setPhone( String value )
  {
      this.phone = value;
  }
  
  /**
   * @return String
   */
  public String getVerificationToken()
  {
      return verificationToken;
  }
  
  /**
   * @param verificationToken String
   */
  public void setVerificationToken( String value )
  {
      this.verificationToken = value;
  }
  
  
  
  
  /**
   * @return int
   */
  public int getIdUser()
  {
      return idUser;
  }
  
  /**
   * @param idUser int
   */
  public void setIdUser( int value )
  {
      this.idUser = value;
  }
     
  
  /**
   * @return Date
   */
  public Timestamp getCreation()
  {
      return creation;
  }
  
  /**
   * @param creation Date
   */
  public void setCreation( Timestamp value )
  {
      this.creation = value;
  }
  

  /**
   * @return boolean
   */
  public boolean isActive()
  {
      return active;
  }
  
  /**
   * @param active boolean
   */
  public void setActive( boolean value )
  {
      this.active = value;
  }
  
  
}
