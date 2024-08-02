-- Find movie title in each genre with highest average movie rating rounded
-- and Print those many Stars '*'
CREATE TABLE movies (
    id INT PRIMARY KEY,
    genre VARCHAR(50),
    title VARCHAR(100)
);

-- Create reviews table
CREATE TABLE reviews (
    movie_id INT,
    rating DECIMAL(3,1),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

-- Insert sample data into movies table
INSERT INTO movies (id, genre, title) VALUES
(1, 'Action', 'The Dark Knight'),
(2, 'Action', 'Avengers: Infinity War'),
(3, 'Action', 'Gladiator'),
(4, 'Action', 'Die Hard'),
(5, 'Action', 'Mad Max: Fury Road'),
(6, 'Drama', 'The Shawshank Redemption'),
(7, 'Drama', 'Forrest Gump'),
(8, 'Drama', 'The Godfather'),
(9, 'Drama', 'Schindler''s List'),
(10, 'Drama', 'Fight Club'),
(11, 'Comedy', 'The Hangover'),
(12, 'Comedy', 'Superbad'),
(13, 'Comedy', 'Dumb and Dumber'),
(14, 'Comedy', 'Bridesmaids'),
(15, 'Comedy', 'Anchorman: The Legend of Ron Burgundy');

-- Insert sample data into reviews table
INSERT INTO reviews (movie_id, rating) VALUES
(1, 4.5),
(1, 4.0),
(1, 5.0),
(2, 4.2),
(2, 4.8),
(2, 3.9),
(3, 4.6),
(3, 3.8),
(3, 4.3),
(4, 4.1),
(4, 3.7),
(4, 4.4),
(5, 3.9),
(5, 4.5),
(5, 4.2),
(6, 4.8),
(6, 4.7),
(6, 4.9),
(7, 4.6),
(7, 4.9),
(7, 4.3),
(8, 4.9),
(8, 5.0),
(8, 4.8),
(9, 4.7),
(9, 4.9),
(9, 4.5),
(10, 4.6),
(10, 4.3),
(10, 4.7),
(11, 3.9),
(11, 4.0),
(11, 3.5),
(12, 3.7),
(12, 3.8),
(12, 4.2),
(13, 3.2),
(13, 3.5),
(13, 3.8),
(14, 3.8),
(14, 4.0),
(14, 4.2),
(15, 3.9),
(15, 4.0),
(15, 4.1);




/*
with my_rating as (
                    select movie_id, avg(rating) as avg_rating
                    from reviews
                    group by movie_id
                    )
, scope as (select m.*, mr.avg_rating 
            from movies m 
            inner join my_rating mr 
                on m.id = mr.movie_id
           )
, f_scope as (select genre, title, avg_rating,
            dense_rank() over(partition by genre order by avg_rating desc) as rn
            from scope)
select genre, title, round(avg_rating)
from f_scope
where rn = 1;
*/

-- Issue with the query, we have 2 records with rank 1 in Comedy genre
-- to be fixed by using ROW_NUMBER() in place of DENSE_RANK()
with scope as (select m.genre, m.title, avg(r.rating) as avg_rating
            from movies m 
            inner join reviews r 
                on m.id = r.movie_id
            group by m.genre, m.title
           )
, f_scope as (select genre, title, avg_rating,
            dense_rank() over(partition by genre order by avg_rating desc) as rn
            from scope)
select genre, title, round(avg_rating)
from f_scope
where rn = 1;

-- Final query 
with scope as (select m.genre, m.title, avg(r.rating) as avg_rating
            from movies m 
            inner join reviews r 
                on m.id = r.movie_id
            group by m.genre, m.title
           )
, f_scope as (select genre, title, avg_rating,
            ROW_NUMBER() over(partition by genre order by avg_rating desc) as rn
            from scope)
select genre, title, round(avg_rating) as avg_rating,
repeat('*', round(avg_rating)) as Stars
from f_scope
where rn = 1;