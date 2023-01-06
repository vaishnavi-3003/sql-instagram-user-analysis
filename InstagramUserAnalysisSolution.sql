/*We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON?*/
SELECT
username,
photos.id,
photos.image_url,
COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
ON likes.photo_id = photos.id
INNER JOIN users
ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;


/*A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/
SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC
limit 5;



/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/
SELECT
DAYNAME(created_at) AS day,
COUNT(*) AS total_users_registered
FROM users
GROUP BY day
ORDER BY total_users_registered DESC
LIMIT 3;




/*Our Investors want to know...
How many times does the average user post?*/

SELECT users.username,COUNT(photos.image_url) as total_posts_by_user
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY total_posts_by_user DESC;

/*total number of photos/total number of users*/
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2);



/*We have a small problem with bots on our site...
Find users who have liked every single photo on the site*/
SELECT users.id,username, COUNT(users.id) As
total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*)
FROM photos);





 