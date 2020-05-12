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
    post_id int(100),
    PRIMARY KEY (post_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
DROP TABLE IF EXISTS `GroupPhotos`;
CREATE TABLE GroupPhotos(
    group_id int(100),
    photo_id int(100),
    PRIMARY KEY (photo_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(photo_id) REFERENCES Photos (photo_id)  ON DELETE CASCADE ON UPDATE CASCADE
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
    PRIMARY KEY (comment_id),
    FOREIGN KEY(comment_id) REFERENCES Posts(post_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
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

GO
CREATE PROCEDURE CreateUser (@user_id int(100),@user_f_name VARCHAR(100), @user_l_name VARCHAR(100),@user_email VARCHAR(100),@user_dob DATE,@user_tel INT(50),@user_addr VARCHAR(100), @user_password VARCHAR(100))
AS
INSERT INTO Users VALUES(@user_id,@user_f_name,@user_l_name,@user_dob,@user_password,@user_addr);
INSERT INTO Emails VALUES(@user_id,@user_email);
INSERT INTO Telephones VALUES(@user_id,@user_tel);
GO

CREATE PROCEDURE CreateProfile (@user_id int(100),@profile_description text,@profile_photo IMAGE)
AS
INSERT INTO Profiles VALUES(@user_id,@profile_description,@profile_photo);
GO

CREATE PROCEDURE AddPhoto (@ photo_id int(100),@user_id int(100),@photo_name VARCHAR(100),@photo_image IMAGE,@photo_datetime DATETIME)
AS
INSERT INTO Photos VALUES(@photo_id,@user_id,@photo_name,@photo_image,@photo_datetime);
GO

CREATE PROCEDURE AddGroupPhoto(@group_id int(100),@ photo_id int(100))
AS
INSERT INTO GroupPhotos VALUES(@group_id,@photo_id);
GO

CREATE PROCEDURE AddPost (@post_id int(100),@user_id int(100),@post_text text,@post_datetime DATETIME)
AS
INSERT INTO Posts VALUES(@post_id,@user_id,@post_text,@post_datetime);
GO

CREATE PROCEDURE AddComment(@comment_id int(100),@post_id int(100))
AS
INSERT INTO Comments VALUES(@comment_id,@post_id);
GO

CREATE PROCEDURE AddPhotoComment(@comment_id int(100),@ photo_id int(100))
AS
INSERT INTO PhotoComments VALUES(@comment_id,@photo_id);
GO

CREATE PROCEDURE AddFriend (@user_id int(100),@friend_id int(100),@friend_type VARCHAR(100))
AS
INSERT INTO Friends VALUES(@user_id,@friend_id,@friend_type);
GO

CREATE PROCEDURE CreateGroup ( @group_id int(100),@user_id int(100),@group_name VARCHAR(100),@group_description text)
AS
INSERT INTO Groups VALUES(@group_id,@user_id,@group_name,@group_description);
GO

CREATE PROCEDURE AddGroupPost ( @group_id int(100),@post_id VARCHAR)
AS
INSERT INTO GroupPosts VALUES(@group_id,@post_id);
GO

CREATE PROCEDURE AddGroupMembers ( @group_id int(100),@user_id int(100),@member_status VARCHAR(100))
AS
INSERT INTO GroupMembers VALUES(@group_id,@user_id,@member_status);
GO

CREATE PROCEDURE CreateGuests (@guest_id VARCHAR(100),@guest_name VARCHAR(100),@guest_email VARCHAR(100),@guest_addr VARCHAR(100),@guest_password VARCHAR (100),@guest_telephone VARCHAR(100))
AS
INSERT INTO GroupMembers VALUES(@guest_id,@guest_name,@guest_email,@guest_addr,@guest_password,@guest_telephone);
GO

CREATE PROCEDURE GetJustPosts 
AS
SELECT * FROM Posts WHERE NOT post_id IN (SELECT comment_id FROM Comments);
GO

CREATE PROCEDURE GetAllComments
AS
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments);
GO

CREATE PROCEDURE GetAllGroupPosts 
AS
SELECT * FROM Posts WHERE post_id IN (SELECT post_id FROM GroupPosts);
GO

CREATE PROCEDURE GetAllGroupPhotos 
AS
SELECT * FROM Photos WHERE photo_id IN (SELECT photo_id FROM GroupPhotos);
GO

CREATE PROCEDURE GetAllUsers
AS
SELECT * FROM Users;
GO

CREATE PROCEDURE GetAllGuests
AS
SELECT * FROM Guests;
GO


CREATE PROCEDURE GetAllPhotos
AS
SELECT * FROM Photos;
GO

CREATE PROCEDURE GetAllGroups
AS
SELECT * FROM Groups;
GO

CREATE PROCEDURE GetAllEmails
AS
SELECT * FROM Emails;
GO

CREATE PROCEDURE GetAllTelephones
AS
SELECT * FROM Telephones;
GO

CREATE PROCEDURE GetPostComments (@post_id int(100))
AS
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments WHERE post_id=@post_id) ;
GO

CREATE PROCEDURE GetPhotoComments (@ photo_id int(100))
AS
SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM PhotoComments WHERE photo_id=@photo_id) ;
GO

CREATE PROCEDURE GetGroupCreator (@group_id int(100))
AS
SELECT * FROM Users WHERE user_id IN (SELECT user_id FROM Groups WHERE group_id=@group_id) ;
GO

CREATE PROCEDURE GetGroupName (@group_id int(100))
AS
SELECT group_name FROM Groups WHERE group_id=@group_id ;
GO

CREATE PROCEDURE GetGroupDescription (@group_id int(100))
AS
SELECT group_description FROM Groups WHERE group_id=@group_id ;
GO

CREATE PROCEDURE GetGroupPosts (@group_id int(100))
AS
SELECT * FROM Posts WHERE post_id IN (SELECT post_id FROM GroupPosts WHERE group_id=@group_id) ;
GO

CREATE PROCEDURE GetGroupPhotos (@group_id int(100))
AS
SELECT * FROM Photos WHERE photo_id IN (SELECT photo_id FROM GroupPhotos WHERE group_id=@group_id) ;
GO

CREATE PROCEDURE GetGroupMembers (@group_id int(100))
AS
SELECT * FROM Users WHERE user_id IN (SELECT user_id FROM GroupMembers WHERE group_id=@group_id) ;
GO

CREATE PROCEDURE GetUserFname (@user_id VARCHAR(100))
AS
SELECT user_f_name FROM Users WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserLname (@user_id VARCHAR(100))
AS
SELECT user_Lname FROM Users WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserDob (@user_id VARCHAR(100))
AS
SELECT user_dob FROM Users WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserPassword (@user_id VARCHAR(100))
AS
SELECT user_password FROM Users WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserAddress (@user_id VARCHAR(100))
AS
SELECT user_addr FROM Users WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserEmail (@user_id VARCHAR(100))
AS
SELECT user_email FROM Emails WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserTelephone (@user_id VARCHAR(100))
AS
SELECT user_tel FROM Telephones WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserProfile (@user_id VARCHAR(100))
AS
SELECT * FROM Profiles WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetUserPosts (@user_id VARCHAR(100))
AS
SELECT * FROM Posts WHERE user_id=@user_id AND NOT post_id IN (SELECT comment_id FROM Comments) ;
GO

CREATE PROCEDURE GetUserComments (@user_id VARCHAR(100))
AS
SELECT * FROM Posts WHERE user_id=@user_id AND post_id IN (SELECT comment_id FROM Comments) ;
GO

CREATE PROCEDURE GetUserFriends (@user_id VARCHAR(100))
AS
SELECT * FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id=@user_id);
GO

CREATE PROCEDURE GetUserPhotos (@user_id VARCHAR(100))
AS
SELECT * FROM Photos WHERE user_id=@user_id;
GO

CREATE PROCEDURE GetFriendsPosts (@user_id int(100),@friend_id int(100))
AS
SELECT * FROM Posts WHERE user_id IN  (SELECT friend_id FROM Friends WHERE user_id=@user_id AND friend_id=@friend_id);
GO

CREATE PROCEDURE GetUserFriendsNames (@user_id VARCHAR(100))
AS
SELECT user_f_name,user_l_name FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id1=@user_id);
GO

CREATE PROCEDURE GetAllUsers_Friends_posts 
AS
SELECT * FROM Users INNER JOIN Friends ON Users.user_id=Friends.user_id INNER JOIN Posts ON Friends.user_id=Posts.user_id;
GO

CREATE PROCEDURE UpdateUserProfilePicture (@user_id int(100),@profile_photo IMAGE)
AS
UPDATE Profiles SET profile_photo=@profile_photo WHERE user_id=@user_id;
GO

CREATE PROCEDURE UpdateUserProfileDescription (@user_id int(100),@profile_description TEXT)
AS
UPDATE Profiles SET profile_description=@profile_description WHERE user_id=@user_id;
GO

CREATE PROCEDURE UpdateUserFirstName (@user_id int(100),@user_f_name VARCHAR(100))
AS
UPDATE Users SET user_f_name=@user_f_name WHERE user_id=@user_id;
GO

CREATE PROCEDURE UpdateUserLastName (@user_id int(100),@user_l_name VARCHAR(100))
AS
UPDATE Users SET user_l_name=@user_l_name WHERE user_id=@user_id;
GO


CREATE VIEW [Posts] 
AS
SELECT * FROM Posts;
