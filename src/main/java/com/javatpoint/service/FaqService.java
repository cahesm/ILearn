package com.javatpoint.service;

import com.javatpoint.model.Faq;
import com.javatpoint.model.Search;
import java.util.List;

public interface FaqService {
    
  void register( Faq faq );
  void update( Faq faq );
  void delete( int idFaq );  
  Faq getFaq( int idFaq );
  List<Faq> getFaqs();
  List<Faq> getFaqs( Search filter );
      
}
