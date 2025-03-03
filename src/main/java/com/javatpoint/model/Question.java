package com.javatpoint.model;

import java.util.ArrayList;
import java.util.List;



public class Question {

    
  private int idQuestion;
  private int idClass;
  private int seq;
  private int rightOption;
  
  private String question = "";
  private String answer = "";
  
  private List<Answer> answers = new ArrayList(); 
  
    /**
     * @return the idQuestion
     */
    public int getIdQuestion() {
        return idQuestion;
    }

    /**
     * @param idQuestion the idQuestion to set
     */
    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
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
     * @return the seq
     */
    public int getSeq() {
        return seq;
    }

    /**
     * @param seq the seq to set
     */
    public void setSeq(int seq) {
        this.seq = seq;
    }

    /**
     * @return the rightOption
     */
    public int getRightOption() {
        return rightOption;
    }

    /**
     * @param rightOption the rightOption to set
     */
    public void setRightOption(int rightOption) {
        this.rightOption = rightOption;
    }

    /**
     * @return the question
     */
    public String getQuestion() {
        return question;
    }

    /**
     * @param question the question to set
     */
    public void setQuestion(String question) {
        this.question = question;
    }

    /**
     * @return the answer
     */
    public String getAnswer() {
        return answer;
    }

    /**
     * @param answer the answer to set
     */
    public void setAnswer(String answer) {
        this.answer = answer;
    }

    /**
     * @return the answers
     */
    public List<Answer> getAnswers() {
        return answers;
    }

    /**
     * @param answers the answers to set
     */
    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

              
  
  
  
}
