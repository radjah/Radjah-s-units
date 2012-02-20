SELECT     connector.id_place, contact.id_sig, COUNT(contact.id_sig) AS sigcount
FROM         connector INNER JOIN
                      contact ON connector.id = contact.id_conn
GROUP BY connector.id_place, contact.id_sig
HAVING      (id_sig = 8 and COUNT(id_sig) > 5)
ORDER BY id_place
