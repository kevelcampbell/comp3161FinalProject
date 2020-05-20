CREATE DATABASE IF NOT EXISTS `mybook`;
USE `mybook`;

DROP TABLE IF EXISTS `Users`;
CREATE TABLE Users(
    user_id int(100) NOT NULL AUTO_INCREMENT,
    user_fname VARCHAR(100),
    user_lname VARCHAR(100),
    user_dob DATE,
    user_password VARCHAR(100),
    user_addr VARCHAR(100), 
    PRIMARY KEY(user_id)
) ENGINE=InnoDB AUTO_INCREMENT=6200 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `Emails`;
CREATE TABLE Emails(
    user_id int(100),
    user_email VARCHAR(100),
    PRIMARY KEY(user_id,user_email),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Telephones`;
CREATE TABLE Telephones(
    user_id int(100),
    user_tel INT(50),
    PRIMARY KEY (user_id,user_tel),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Profiles`;
CREATE TABLE Profiles(
    user_id int(100),
    profile_description text,
    profile_photo BLOB,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Photos`;
CREATE TABLE Photos(
    photo_id int(100) NOT NULL AUTO_INCREMENT,
    user_id int(100),
    photo_name VARCHAR(100),
    photo_image BLOB,
    photo_datetime DATETIME,
    PRIMARY KEY(photo_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `Posts`;
CREATE TABLE Posts(
    post_id int(100) NOT NULL AUTO_INCREMENT,
    user_id int(100),
    post_text text,
    post_datetime DATETIME,
    PRIMARY KEY (post_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `Groups`;
CREATE TABLE Groups(
    group_id int(100) NOT NULL AUTO_INCREMENT,
    user_id int(100),
    group_name VARCHAR(100),
    group_description text,
    PRIMARY KEY(group_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `GroupMembers`;
CREATE TABLE GroupMembers(
    group_id int(100),
    user_id int(100),
    member_status VARCHAR(100),
    PRIMARY KEY(group_id,user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Friends`;
CREATE TABLE Friends( 
    user_id int(100),
    friend_id int(100),
    friend_type VARCHAR(100),
    PRIMARY KEY(user_id,friend_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(friend_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `GroupPosts`;
CREATE TABLE GroupPosts(
    group_id int(100),
    post_id int(100) NOT NULL AUTO_INCREMENT,
    group_post VARCHAR(100),
    post_datetime DATETIME,
    PRIMARY KEY (post_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `GroupPhotos`;
CREATE TABLE GroupPhotos(
    group_id int(100),
    photo_id int(100),
    PRIMARY KEY (photo_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(photo_id) REFERENCES Photos (photo_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `GroupAdmin`;
CREATE TABLE GroupAdmin(
    group_id int(100),
    user_id int(100),
    PRIMARY KEY(group_id, user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS `PhotoComments`;
CREATE TABLE PhotoComments(
    comment_id int(100),
    photo_id int(100),
    PRIMARY KEY (comment_id),
    FOREIGN KEY(comment_id) REFERENCES Posts(post_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(photo_id) REFERENCES Photos (photo_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Comments`;
CREATE TABLE Comments(
    comment_id int(100),
    post_id int(100),
    PRIMARY KEY (comment_id)
);

DROP TABLE IF EXISTS `Guests`;
CREATE TABLE Guests(
    guest_id int(100),
    guest_name VARCHAR(100),
    guest_email VARCHAR(100),
    guest_addr VARCHAR(100),
    guest_password VARCHAR (100),
    guest_telephone VARCHAR(100),
    PRIMARY KEY (guest_id)
);

DROP TABLE IF EXISTS `Admin`;
CREATE TABLE Admin(
    user_id int(100),
    PRIMARY KEY(user_id)
);


DELIMITER //
CREATE PROCEDURE CreateUser ( IN User_id INT(100),IN User_fname VARCHAR(100), IN User_l_name VARCHAR(100),IN User_email VARCHAR(100),IN User_dob DATE,IN User_tel INT(50),IN User_addr VARCHAR(100), IN User_password VARCHAR(100))
BEGIN
INSERT INTO Users VALUES(User_id,User_fname,User_l_name,User_dob,User_password,User_addr);
INSERT INTO Emails VALUES(User_id,User_email);
INSERT INTO Telephones VALUES(User_id,User_tel);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE CreateProfile (IN User_id INT(100),IN Profile_description text,IN Profile_photo BLOB)
BEGIN
INSERT INTO Profiles VALUES(User_id,Profile_description,Profile_photo);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddPhoto (IN Photo_id INT(100),IN User_id INT(100),IN Photo_name VARCHAR(100),IN Photo_image BLOB,IN Photo_datetime DATETIME)
BEGIN
INSERT INTO Photos VALUES(Photo_id,User_id,Photo_name,Photo_image,Photo_datetime);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddGroupPhoto(IN Photo_id INT(100),IN Group_id INT(100))
BEGIN
INSERT INTO GroupPhotos VALUES(Photo_id,Group_id);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddPost (IN Post_id INT(100),IN User_id INT(100),IN Post_text text,IN Post_datetime DATETIME)
BEGIN
INSERT INTO Posts VALUES(Post_id,User_id,Post_text,Post_datetime);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddComment(IN Comment_id INT(100),IN Post_id INT(100))
BEGIN
INSERT INTO Comments VALUES( Comment_id,Post_id);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddPhotoComment(IN Comment_id INT(100),IN Photo_id INT(100))
BEGIN
INSERT INTO PhotoComments VALUES(Comment_id,Photo_id);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddFriend (IN User_id INT(100),IN Friend_id INT(100),IN Friend_type VARCHAR(100))
BEGIN
INSERT INTO Friends VALUES(User_id,Friend_id,Friend_type);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE CreateGroup ( IN Group_id INT(100),IN User_id int(100),IN Group_name VARCHAR(100),IN Group_description text)
BEGIN
INSERT INTO Groups VALUES(Group_id,User_id,Group_name,Group_description);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddGroupPost (IN Post_id INT,IN Group_id INT(100))
BEGIN
INSERT INTO GroupPosts VALUES(Post_id,Group_id);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE AddGroupMembers ( IN Group_id INT(100),IN User_id INT(100),IN Member_status VARCHAR(100))
BEGIN
INSERT INTO GroupMembers VALUES(Group_id,User_id,Member_status);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE CreateGuests (IN Guest_id INT(100),IN Guest_name VARCHAR(100),IN Guest_email VARCHAR(100),IN Guest_addr VARCHAR(100),IN Guest_password VARCHAR (100),IN Guest_telephone VARCHAR(100))
BEGIN
INSERT INTO GroupMembers VALUES(Guest_id,Guest_name,Guest_email,Guest_addr,Guest_password,Guest_telephone);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetJustPosts 
BEGIN
SELECT * FROM Posts WHERE post_id NOT IN (SELECT comment_id FROM Comments ) AND post_id NOT IN (SELECT comment_id FROM PhotoComments ) AND post_id Not IN (SELECT post_id FROM GroupPosts) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllComments
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllPhotoComments
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM PhotoComments);
END //
DELIMITER;



DELIMITER //
CREATE PROCEDURE GetAllGroupPosts()
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT post_id FROM GroupPosts);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllGroupPhotos()
BEGIN
SELECT * FROM Photos WHERE photo_id IN (SELECT photo_id FROM GroupPhotos);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllUsers()
BEGIN
SELECT * FROM Users;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllGuests()
BEGIN
SELECT * FROM Guests;
END //
DELIMITER;


DELIMITER //
CREATE PROCEDURE GetAllPhotos()
BEGIN
SELECT * FROM Photos;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllGroups()
BEGIN
SELECT * FROM Groups;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllEmails()
BEGIN
SELECT * FROM Emails;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllTelephones()
BEGIN
SELECT * FROM Telephones;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetPostComments (IN Post_id INT(100))
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments WHERE post_id=Post_id) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetPhotoComments (IN Photo_id INT(100))
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM PhotoComments WHERE photo_id=Photo_id) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetGroupCreator (IN Group_id INT(100))
BEGIN
SELECT * FROM Users WHERE user_id IN (SELECT user_id FROM Groups WHERE group_id=Group_id) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetGroupName (IN Group_id INT(100))
BEGIN
SELECT group_name FROM Groups WHERE group_id=Group_id ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetGroupDescription (IN Group_id INT(100))
BEGIN
SELECT group_description FROM Groups WHERE group_id=Group_id ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetGroupPosts (IN Group_id INT(100))
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT post_id FROM GroupPosts WHERE group_id=Group_id) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetGroupPhotos (IN Group_id INT(100))
BEGIN
SELECT * FROM Photos WHERE photo_id IN (SELECT photo_id FROM GroupPhotos WHERE group_id=Group_id) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetGroupMembers (IN Group_id INT(100))
BEGIN
SELECT * FROM Users WHERE user_id IN (SELECT user_id FROM GroupMembers WHERE group_id=Group_id) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserFname (IN User_id INT(100))
BEGIN
SELECT user_fname FROM Users WHERE user_id=User_id
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUser_Lname (IN User_id INT(100))
BEGIN
SELECT user_l_name FROM Users WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserDob (IN User_id INT(100))
BEGIN
SELECT user_dob FROM Users WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserPassword (IN User_id INT(100))
BEGIN
SELECT user_password FROM Users WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserAddress (IN User_id INT(100))
BEGIN
SELECT user_addr FROM Users WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserEmail (IN User_id INT(100))
BEGIN
SELECT user_email FROM Emails WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserTelephone (IN User_id INT(100))
BEGIN
SELECT user_tel FROM Telephones WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserProfile (IN User_id INT(100))
BEGIN
SELECT * FROM Profiles WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserPosts (IN User_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id=User_id AND post_id NOT IN (SELECT comment_id FROM Comments ) AND  post_id NOT IN (SELECT comment_id FROM PhotoComments ) AND post_id NOT IN (SELECT post_id FROM GroupPosts) ;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserComments (IN User_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id=User_id AND post_id IN (SELECT comment_id FROM Comments);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserPhotoComments (IN User_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id=User_id AND post_id IN (SELECT comment_id FROM PhotoComments);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserFriends (IN User_id INT(100))
BEGIN
SELECT * FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id=User_id);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserPhotos (IN User_id INT(100))
BEGIN
SELECT * FROM Photos WHERE user_id=User_id AND  NOT photo_id IN (SELECT photo_id FROM GroupPhotos);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetFriendsPosts (IN User_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id IN  (SELECT friend_id FROM Friends WHERE user_id=User_id) AND post_id NOT IN (SELECT comment_id FROM Comments ) AND post_id  NOT IN (SELECT comment_id FROM PhotoComments ) AND post_id NOT IN (SELECT post_id FROM GroupPosts) ;;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetUserFriendsNames (IN User_id INT(100))
BEGIN
SELECT user_fname,user_l_name FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id1=User_id);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE GetAllUsers_Friends_posts()
BEGIN
SELECT * FROM Users INNER JOIN Friends ON Users.user_id=Friends.user_id INNER JOIN Posts ON Friends.user_id=Posts.user_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE UpdateUserProfilePicture (IN User_id INT(100),IN Profile_photo BLOB)
BEGIN
UPDATE Profiles SET profile_photo=Profile_photo WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE UpdateUserProfileDescription (IN User_id INT(100),IN Profile_description TEXT)
BEGIN
UPDATE Profiles SET profile_description=Profile_description WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE UpdateUserFirstName (IN User_id INT(100),IN User_fname VARCHAR(100))
BEGIN
UPDATE Users SET user_fname=User_fname WHERE user_id=User_id;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE UpdateUserLastName (IN User_id INT(100),IN User_l_name VARCHAR(100))
BEGIN
UPDATE Users SET user_l_name=User_l_name WHERE user_id=ser_id;
END //
DELIMITER;
