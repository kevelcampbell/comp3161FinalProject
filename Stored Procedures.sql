DELIMITER //

CREATE PROCEDURE GetUsersFirstNames()
BEGIN 
    SELECT user_fname FROM users;
END //

DELIMITER ;

CALL GetUsersFirstNames();



DELIMITER //

CREATE PROCEDURE GetPostsWithoutComments()
BEGIN 
    SELECT * FROM Posts WHERE NOT post_id IN (SELECT comment_id FROM Comments ) AND NOT post_id IN (SELECT comment_id FROM PhotoComments ) AND  NOT post_id IN (SELECT post_id FROM GroupPosts) ;
END //

DELIMITER ;

CALL GetPostsWithoutComments();
