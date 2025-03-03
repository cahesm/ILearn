package com.javatpoint.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;



public class StudyClass {
             
  private String name;
  private String token;
      
  private int idClass;
  private int idUser;
  
  private Timestamp creation;
  
  private List<Content> contents = new ArrayList();
  private List<Question> questions = new ArrayList();
  
  /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the idClass
     */
    public int getIdClass() {
        return idClass;
    }

    /**
     * @param idClass the idClass to set
     */
    public void setIdClass(int idClass) {
        this.idClass = idClass;
    }

    /**
     * @return the idUser
     */
    public int getIdUser() {
        return idUser;
    }

    /**
     * @param idUser the idUser to set
     */
    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    /**
     * @return the creation
     */
    public Timestamp getCreation() {
        return creation;
    }

    /**
     * @param creation the creation to set
     */
    public void setCreation(Timestamp creation) {
        this.creation = creation;
    }
    
    /**
     * @return the contents
     */
    public List<Content> getContents() {
        return contents;
    }

    /**
     * @param contents the contents to set
     */
    public void setContents(List<Content> contents) {
        this.contents = contents;
    }

    /**
     * @return the questions
     */
    public List<Question> getQuestions() {
        return questions;
    }

    /**
     * @param questions the questions to set
     */
    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    /**
     * @return the token
     */
    public String getToken() {
        return token;
    }

    /**
     * @param token the token to set
     */
    public void setToken(String token) {
        this.token = token;
    }

  
}
