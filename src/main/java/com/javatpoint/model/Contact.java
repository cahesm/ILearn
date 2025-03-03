package com.javatpoint.model;

public class Contact {
    
  private String name;
  private String email;
  private String phone;
  private String message;

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
  
  /**
   * @return String
   */
  public String getEmail()
  {
      return email;
  }
  
  /**
   * @param email String
   */
  public void setEmail( String value )
  {
      this.email = value;
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
  public String getMessage()
  {
      return message;
  }
  
  /**
   * @param message String
   */
  public void setMessage( String value )
  {
      this.message = value;
  }
  
  
}
