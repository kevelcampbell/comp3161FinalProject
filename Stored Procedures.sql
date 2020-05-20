DROP PROCEDURE IF EXISTS GetUsersFirstNames;
DELIMITER //

CREATE PROCEDURE GetUsersFirstNames()
BEGIN 
    SELECT user_fname FROM users;
END //

DELIMITER ;

CALL GetUsersFirstNames();


DROP PROCEDURE IF EXISTS GetPostsWithoutComments;
DELIMITER //

CREATE PROCEDURE GetPostsWithoutComments()
BEGIN 
    SELECT * FROM Posts WHERE NOT post_id IN (SELECT comment_id FROM Comments ) AND NOT post_id IN (SELECT comment_id FROM PhotoComments ) AND  NOT post_id IN (SELECT post_id FROM GroupPosts) ;
END //

DELIMITER ;

CALL GetPostsWithoutComments();



DROP PROCEDURE IF EXISTS GetUserIDeByGroup;
DELIMITER //

CREATE PROCEDURE GetUserIDeByGroup(
	IN groupName VARCHAR(255)
)
BEGIN
	SELECT user_id
 	FROM groups
	WHERE group_name = groupName;
END //

DELIMITER ;

CALL GetUserIDeByGroup(/*ENTER GROUP NAME*/);



DROP PROCEDURE IF EXISTS GetPostsByUserID;
DELIMITER //

CREATE PROCEDURE GetPostsByUserID(
	IN userID VARCHAR(255)
)
BEGIN
	SELECT post_text, post_datetime
 	FROM posts
	WHERE user_id = userID;
END //

DELIMITER ;

CALL GetPostsByUserID(/*ENTER USER ID*/);



DROP PROCEDURE IF EXISTS AddUser;
DELIMITER //

CREATE PROCEDURE AddUser(
    IN user_fname VARCHAR(100),
    IN user_lname VARCHAR(100),
    IN user_dob DATE, 
    IN user_password VARCHAR(100), 
    IN user_addr VARCHAR(100)
)
BEGIN
	INSERT INTO users(user_fname, user_lname, user_dob, user_password, user_addr)
 	VALUES (user_fname, user_lname, user_dob, user_password, user_addr);
END //

DELIMITER ;


CALL AddUser(/*Enter user firstname, lastname, dob,password and address*/);











