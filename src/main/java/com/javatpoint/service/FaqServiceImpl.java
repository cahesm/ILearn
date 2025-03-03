package com.javatpoint.service;

import com.javatpoint.dao.FaqDao;
import com.javatpoint.model.Faq;
import com.javatpoint.model.Search;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class FaqServiceImpl implements FaqService {

  @Autowired
  public FaqDao faqDao;
  
  public void register( Faq faq )
  {
      faqDao.register( faq );
  }
  
  public void update( Faq faq )
  {
      faqDao.update( faq );
  }
  
  public void delete( int idFaq )
  {
      faqDao.delete( idFaq );
  }
  
  
  public Faq getFaq( int idFaq ) {
    return faqDao.getFaq( idFaq );
  }
  public List<Faq> getFaqs() {
    return faqDao.getFaqs();
  }
  public List<Faq> getFaqs( Search filter ) {
    return faqDao.getFaqs( filter );
  }
  
  
  
  
}
