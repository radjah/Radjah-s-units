declare @i int
set @i = 5

while (@i<10)
begin
select sigtag from signame
where sigid=@i
set @i = @i + 1
end