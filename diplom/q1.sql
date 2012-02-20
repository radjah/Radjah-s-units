SELECT       id_place
FROM         connector INNER JOIN contact A1 on connector.id = A1.id_conn
                       CROSS JOIN contact A2
                       CROSS JOIN contact A3

GROUP BY c1.id_place, A1.id_sig, c2.id_place, A2.id_sig, c3.id_place, A3.id_sig
HAVING      (A1.id_sig = 1 and COUNT(A1.id_sig) >= 4) 
        and (A2.id_sig = 2 and COUNT(A2.id_sig) >= 1)
        and (A3.id_sig = 8 and COUNT(A3.id_sig) >= 10)
ORDER BY id_place