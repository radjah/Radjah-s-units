SELECT distinct places.id,places.placename
FROM     places INNER JOIN ##contact A1 on A1.id_place=places.id  CROSS JOIN ##contact A2 CROSS JOIN ##contact A3
GROUP BY id,placename,A1.id_sig,A1.sigcount,A2.id_sig,A2.sigcount,A3.id_sig,A3.sigcount
HAVING      (A1.id_sig = 1 and A1.sigcount >= 4) and (A2.id_sig = 2 and A2.sigcount >= 1) and (A3.id_sig = 9 and A3.sigcount >= 1)
ORDER BY id