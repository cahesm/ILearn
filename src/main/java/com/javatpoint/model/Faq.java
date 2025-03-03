/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.model;

/**
 *
 * @author usuario
 */
public class Faq {
    
   
    private int idFaq;
   
    private String question;
    private String answer;
    
    private String token;  
    
    /**
     * @return int
     */
    public int getIdFaq()
    {
        return idFaq;
    }
    
    /**
     * @param idFaq int
     */
    public void setIdFaq( int value )
    {
        this.idFaq = value;
    }
    
    /**
     * @return String
     */
    public String getQuestion()
    {
        return question;
    }
    
    /**
     * @param question String
     */
    public void setQuestion( String value )
    {
        this.question = value;
    }
    
    /**
     * @return String
     */
    public String getAnswer()
    {
        return answer;
    }
    
    /**
     * @param answer String
     */
    public void setAnswer( String value )
    {
        this.answer = value;
    }
    
    
    /**
     * @return String
     */
    public String getToken()
    {
        return token;
    }
    
    /**
     * @param token String
     */
    public void setToken( String value )
    {
        this.token = value;
    }
    

      
}
