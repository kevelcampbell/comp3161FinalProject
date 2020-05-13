CREATE DATABASE IF NOT EXISTS `mybook`;
USE `mybook`;

DROP TABLE IF EXISTS `Users`;
CREATE TABLE Users(
    user_id INT(100) NOT NULL AUTO_INCREMENT,
    user_fname VARCHAR(100),
    user_lname VARCHAR(100),
    user_dob DATE,
    user_password VARCHAR(100),
    user_addr VARCHAR(100), 
    PRIMARY KEY(user_id)
) ENGINE=InnoDB AUTO_INCREMENT=6200 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `Emails`;
CREATE TABLE Emails(
    user_id INT(100),
    user_email VARCHAR(100),
    PRIMARY KEY(user_id,user_email),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Telephones`;
CREATE TABLE Telephones(
    user_id INT(100),
    user_tel INT(50),
    PRIMARY KEY (user_id,user_tel),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Profiles`;
CREATE TABLE Profiles(
    user_id INT(100),
    profile_description text,
    profile_photo BLOB,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Photos`;
CREATE TABLE Photos(
    photo_id INT(100) NOT NULL AUTO_INCREMENT,
    user_id INT(100),
    photo_name VARCHAR(100),
    photo_image BLOB,
    photo_datetime DATETIME,
    PRIMARY KEY(photo_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `Posts`;
CREATE TABLE Posts(
    post_id INT(100) NOT NULL AUTO_INCREMENT,
    user_id INT(100),
    post_text text,
    post_datetime DATETIME,
    PRIMARY KEY (post_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `Groups`;
CREATE TABLE Groups(
    group_id INT(100) NOT NULL AUTO_INCREMENT,
    user_id INT(100),
    group_name VARCHAR(100),
    group_description text,
    PRIMARY KEY(group_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `GroupMembers`;
CREATE TABLE GroupMembers(
    group_id INT(100),
    user_id INT(100),
    member_status VARCHAR(100),
    PRIMARY KEY(group_id,user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Friends`;
CREATE TABLE Friends( 
    user_id INT(100),
    friend_id INT(100),
    friend_type VARCHAR(100),
    PRIMARY KEY(user_id,friend_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(friend_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `GroupPosts`;
CREATE TABLE GroupPosts(
    group_id INT(100),
    post_id INT(100),
    PRIMARY KEY (post_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
DROP TABLE IF EXISTS `GroupPhotos`;
CREATE TABLE GroupPhotos(
    group_id INT(100),
    photo_id INT(100),
    PRIMARY KEY (photo_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(photo_id) REFERENCES Photos (photo_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `PhotoComments`;
CREATE TABLE PhotoComments(
    comment_id INT(100),
    photo_id INT(100),
    PRIMARY KEY (comment_id),
    FOREIGN KEY(comment_id) REFERENCES Posts(post_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(photo_id) REFERENCES Photos (photo_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Comments`;
CREATE TABLE Comments(
    comment_id INT(100),
    post_id INT(100),
    PRIMARY KEY (comment_id),
    FOREIGN KEY(comment_id) REFERENCES Posts(post_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Guests`;
CREATE TABLE Guests(
    guest_id INT(100),
    guest_name VARCHAR(100),
    guest_email VARCHAR(100),
    guest_addr VARCHAR(100),
    guest_password VARCHAR (100),
    guest_telephone VARCHAR(100),
    PRIMARY KEY (guest_id)
);

DELIMITER $$
CREATE PROCEDURE CreateUser (@user_id INT(100),@user_fname VARCHAR(100), @user_l_name VARCHAR(100),@user_email VARCHAR(100),@user_dob DATE,@user_tel INT(50),@user_addr VARCHAR(100), @user_password VARCHAR(100))
BEGIN
INSERT INTO Users VALUES(@user_id,@user_fname,@user_l_name,@user_dob,@user_password,@user_addr);
INSERT INTO Emails VALUES(@user_id,@user_email);
INSERT INTO Telephones VALUES(@user_id,@user_tel);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE CreateProfile (@user_id INT(100),@profile_description text,@profile_photo BLOB)
BEGIN
INSERT INTO Profiles VALUES(@user_id,@profile_description,@profile_photo);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddPhoto (@photo_id INT(100),@user_id INT(100),@photo_name VARCHAR(100),@photo_image BLOB,@photo_datetime DATETIME)
BEGIN
INSERT INTO Photos VALUES(@photo_id,@user_id,@photo_name,@photo_image,@photo_datetime);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddGroupPhoto(@photo_id INT(100),@group_id INT(100))
BEGIN
INSERT INTO GroupPhotos VALUES(@photo_id,group_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddPost (@post_id INT(100),@user_id INT(100),@post_text text,@post_datetime DATETIME)
BEGIN
INSERT INTO Posts VALUES(@post_id,@user_id,@post_text,@post_datetime);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddComment(@comment_id INT(100),@post_id INT(100))
BEGIN
INSERT INTO Comments VALUES(@comment_id,@post_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddPhotoComment(@comment_id INT(100),@photo_id INT(100))
BEGIN
INSERT INTO PhotoComments VALUES(@comment_id,@photo_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddFriend (@user_id INT(100),@friend_id INT(100),@friend_type VARCHAR(100))
BEGIN
INSERT INTO Friends VALUES(@user_id,@friend_id,@friend_type);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE CreateGroup ( @group_id INT(100),@user_id int(100),@group_name VARCHAR(100),@group_description text)
BEGIN
INSERT INTO Groups VALUES(@group_id,@user_id,@group_name,@group_description);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddGroupPost (@post_id INT,@group_id INT(100))
BEGIN
INSERT INTO GroupPosts VALUES(@post_id,@group_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE AddGroupMembers ( @group_id INT(100),@user_id INT(100),@member_status VARCHAR(100))
BEGIN
INSERT INTO GroupMembers VALUES(@group_id,@user_id,@member_status);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE CreateGuests (@guest_id INT(100),@guest_name VARCHAR(100),@guest_email VARCHAR(100),@guest_addr VARCHAR(100),@guest_password VARCHAR (100),@guest_telephone VARCHAR(100))
BEGIN
INSERT INTO GroupMembers VALUES(@guest_id,@guest_name,@guest_email,@guest_addr,@guest_password,@guest_telephone);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetJustPosts 
BEGIN
SELECT * FROM Posts WHERE NOT post_id IN (SELECT comment_id FROM Comments FULL OUTER JOIN PhotoComments ON Comments.comment_id=PhotoComments.comment_id FULL OUTER JOIN GroupPosts ON PhotoComments.comment_id=GroupPosts.post_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllComments
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllPhotoComments
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM PhotoComments);
END $$
DELIMITER;



DELIMITER $$
CREATE PROCEDURE GetAllGroupPosts 
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT post_id FROM GroupPosts);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllGroupPhotos 
BEGIN
SELECT * FROM Photos WHERE photo_id IN (SELECT photo_id FROM GroupPhotos);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllUsers
BEGIN
SELECT * FROM Users;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllGuests
BEGIN
SELECT * FROM Guests;
END $$
DELIMITER;


DELIMITER $$
CREATE PROCEDURE GetAllPhotos
BEGIN
SELECT * FROM Photos;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllGroups
BEGIN
SELECT * FROM Groups;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllEmails
BEGIN
SELECT * FROM Emails;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllTelephones
BEGIN
SELECT * FROM Telephones;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetPostComments (@post_id INT(100))
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments WHERE post_id=@post_id) ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetPhotoComments (@photo_id INT(100))
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM PhotoComments WHERE photo_id=@photo_id) ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetGroupCreator (@group_id INT(100))
BEGIN
SELECT * FROM Users WHERE user_id IN (SELECT user_id FROM Groups WHERE group_id=@group_id) ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetGroupName (@group_id INT(100))
BEGIN
SELECT group_name FROM Groups WHERE group_id=@group_id ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetGroupDescription (@group_id INT(100))
BEGIN
SELECT group_description FROM Groups WHERE group_id=@group_id ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetGroupPosts (@group_id INT(100))
BEGIN
SELECT * FROM Posts WHERE post_id IN (SELECT post_id FROM GroupPosts WHERE group_id=@group_id) ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetGroupPhotos (@group_id INT(100))
BEGIN
SELECT * FROM Photos WHERE photo_id IN (SELECT photo_id FROM GroupPhotos WHERE group_id=@group_id) ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetGroupMembers (@group_id INT(100))
BEGIN
SELECT * FROM Users WHERE user_id IN (SELECT user_id FROM GroupMembers WHERE group_id=@group_id) ;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserFname (@user_id INT(100))
BEGIN
SELECT user_fname FROM Users WHERE user_id=@user_id
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUser_Lname (@user_id INT(100))
BEGIN
SELECT user_l_name FROM Users WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserDob (@user_id INT(100))
BEGIN
SELECT user_dob FROM Users WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserPassword (@user_id INT(100))
BEGIN
SELECT user_password FROM Users WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserAddress (@user_id INT(100))
BEGIN
SELECT user_addr FROM Users WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserEmail (@user_id INT(100))
BEGIN
SELECT user_email FROM Emails WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserTelephone (@user_id INT(100))
BEGIN
SELECT user_tel FROM Telephones WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserProfile (@user_id INT(100))
BEGIN
SELECT * FROM Profiles WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserPosts (@user_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id=@user_id AND NOT post_id IN (SELECT comment_id FROM Comments FULL OUTER JOIN PhotoComments ON Comments.comment_id=PhotoComments.comment_id FULL OUTER JOIN GroupPosts ON PhotoComments.comment_id=GroupPosts.post_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserComments (@user_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id=@user_id AND post_id IN (SELECT comment_id FROM Comments);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserPhotoComments (@user_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id=@user_id AND post_id IN (SELECT comment_id FROM PhotoComments);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserFriends (@user_id INT(100))
BEGIN
SELECT * FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id=@user_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserPhotos (@user_id INT(100))
BEGIN
SELECT * FROM Photos WHERE user_id=@user_id AND  NOT photo_id IN (SELECT photo_id FROM GroupPhotos);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetFriendsPosts (@user_id INT(100))
BEGIN
SELECT * FROM Posts WHERE user_id IN  (SELECT friend_id FROM Friends WHERE user_id=@user_id) AND NOT post_id IN (SELECT comment_id FROM Comments FULL OUTER JOIN PhotoComments ON Comments.comment_id=PhotoComments.comment_id FULL OUTER JOIN GroupPosts ON PhotoComments.comment_id=GroupPosts.post_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetUserFriendsNames (@user_id INT(100))
BEGIN
SELECT user_fname,user_l_name FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id1=@user_id);
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE GetAllUsers_Friends_posts 
BEGIN
SELECT * FROM Users INNER JOIN Friends ON Users.user_id=Friends.user_id INNER JOIN Posts ON Friends.user_id=Posts.user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE UpdateUserProfilePicture (@user_id INT(100),@profile_photo BLOB)
BEGIN
UPDATE Profiles SET profile_photo=@profile_photo WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE UpdateUserProfileDescription (@user_id INT(100),@profile_description TEXT)
BEGIN
UPDATE Profiles SET profile_description=@profile_description WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE UpdateUserFirstName (@user_id INT(100),@user_fname VARCHAR(100))
BEGIN
UPDATE Users SET user_fname=@user_fname WHERE user_id=@user_id;
END $$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE UpdateUserLastName (@user_id INT(100),@user_l_name VARCHAR(100))
BEGIN
UPDATE Users SET user_l_name=@user_l_name WHERE user_id=@user_id;
END $$
DELIMITER;


CREATE VIEW [Posts] 
BEGIN
SELECT * FROM Posts;
