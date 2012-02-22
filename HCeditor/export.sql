SELECT 
  cstruct.corder AS corder, sstruct.clevel AS clevel, sstruct.ptime AS ptime
FROM
  cstruct, sstruct
WHERE
cstruct.cid = 10
AND 
  cstruct.sid = sstruct.sid
ORDER BY
  cstruct.corder, sstruct.clevel
