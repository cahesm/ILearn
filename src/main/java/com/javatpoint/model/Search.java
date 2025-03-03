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
public class Search {
    
    private int pages;
    private int page;
    private int total;
    private int pageSize = 10;
    
    /**
     * @return int
     */
    public int getPages()
    {
        return pages;
    }
    
    /**
     * @param pages int
     */
    public void setPages( int value )
    {
        this.pages = value;
    }
    
    /**
     * @return int
     */
    public int getPage()
    {
        return page;
    }
    
    /**
     * @param page int
     */
    public void setPage( int value )
    {
        this.page = value;
    }
    
    /**
     * @return int
     */
    public int getTotal()
    {
        return total;
    }
    
    /**
     * @param total int
     */
    public void setTotal( int value )
    {
        this.total = value;
    }
    
    /**
     * @return int
     */
    public int getPageSize()
    {
        return pageSize;
    }
    
    /**
     * @param pageSize int
     */
    public void setPageSize( int value )
    {
        this.pageSize = value;
    }
    

}
