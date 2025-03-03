/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.model;

import java.io.Serializable;

public class SearchResultItem implements Serializable
{      
    private int id;
    private int occurrences;
    
    private String name;
    private String term;
 
    /**
     * @return Integer
     */
    public int getId()
    {
        return id;
    }
    
    /**
     * @param id Integer
     */
    public void setId( int value )
    {
        this.id = value;
    }
    
    
    /**
     * @return int
     */
    public int getOccurrences()
    {
        return occurrences;
    }
    
    /**
     * @param occurrences int
     */
    public void setOccurrences( int value )
    {
        this.occurrences = value;
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
    
    
    /**
     * @return String
     */
    public String getTerm()
    {
        return term;
    }
    
    /**
     * @param term String
     */
    public void setTerm( String value )
    {
        this.term = value;
    }
    


}
