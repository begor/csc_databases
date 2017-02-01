CREATE VIEW Count AS SELECT COUNT(*) as count FROM T;                           
                                                                                
SELECT t.value, COUNT(*) FROM T t                                               
LEFT JOIN T t1 ON t.id < t1.id                                                  
JOIN Count                                                                      
GROUP BY t.id                                                                   
HAVING COUNT(*) = (count / 2) + 1;  
