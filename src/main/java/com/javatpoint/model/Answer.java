package com.javatpoint.model;



public class Answer {

    private int idAnswer;
  private int idQuestion;
  private int seq;
  
  private boolean isCorrect = false;
  
  private String answer;
  
    /**
     * @return the idAnswer
     */
    public int getIdAnswer() {
        return idAnswer;
    }

    /**
     * @param idAnswer the idAnswer to set
     */
    public void setIdAnswer(int idAnswer) {
        this.idAnswer = idAnswer;
    }

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
     * @return the correct
     */
    public boolean getIsCorrect() {
        return isCorrect;
    }

    /**
     * @param correct the correct to set
     */
    public void setIsCorrect(boolean correct) {
        this.isCorrect = correct;
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

  
    
    
}
