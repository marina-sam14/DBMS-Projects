CHECKPOINT
DBCC DROPCLEANBUFFERS
SET STATISTICS IO ON 

SELECT DISTINCT movies.title,pyear,movies.mrank,user_movies.rating
FROM movies,user_movies
INNER JOIN users ON users.userid = user_movies.userid
WHERE users.age>40 and user_movies.rating>3 and pyear < '1990' and movies.mrank > 7
GROUP BY movies.title,pyear,movies.mrank,user_movies.rating



select distinct firstName,lastName
from directors
INNER JOIN movie_directors ON directors.did = movie_directors.did
WHERE (EXISTS( SELECT rating,user_movies.mid from user_movies 
INNER JOIN movies ON user_movies.mid = movies.mid
INNER JOIN movies_genre ON user_movies.mid = movies_genre.mid
where rating > 3 and genre = 'Horror' or genre = 'Crime' or genre = 'Thriller'))
GROUP BY firstName,lastName

CREATE NONCLUSTERED INDEX in1 ON directors(firstName,lastName) include (did)
CREATE NONCLUSTERED INDEX in2 ON user_movies(mid) 
CREATE NONCLUSTERED INDEX in3 ON movies_genre(mid) include (genre)
CREATE NONCLUSTERED INDEX in4 ON movie_directors(did)

DROP INDEX in1 ON directors
DROP INDEX in2 ON user_movies
DROP INDEX in3 ON movies_genre
DROP INDEX in4 ON movie_directors