SELECT     probtags.ProbName, probtags.ProbTag, testunits.unname, places.placename, connector.connname, signame.sigtag, contact.contnum
FROM         map INNER JOIN
                      contact ON map.contid = contact.id INNER JOIN
                      unittags ON map.unittag = unittags.id INNER JOIN
                      connector ON connector.id = contact.id_conn INNER JOIN
                      probtags ON unittags.tagid = probtags.id INNER JOIN
                      testunits ON unittags.unitid = testunits.unid INNER JOIN
                      signame ON contact.id_sig = signame.sigid INNER JOIN
                      places ON connector.id_place = places.id