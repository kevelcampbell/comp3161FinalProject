DELIMITER //

CREATE PROCEDURE GetUsersFirstNames()
BEGIN 
    SELECT user_fname FROM users;
END //

DELIMITER ;

CALL GetUsersFirstNames();