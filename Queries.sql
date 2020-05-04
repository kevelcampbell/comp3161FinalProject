CREATE TABLE Users(
    user_id VARCHAR(100),
    user_fname VARCHAR(100),
    user_lname VARCHAR(100),
    user_dob DATE,
    user_password VARCHAR(100),
    user_addr VARCHAR(100), 
    PRIMARY KEY(user_id)
);
CREATE TABLE Emails(
    user_id VARCHAR(100),
    user_email VARCHAR(100)
);
CREATE TABLE Telephones(
    user_id VARCHAR(100),
    user_tel INT(50)
);
CREATE TABLE Profiles(
    user_id VARCHAR(100),
    user_fname VARCHAR(100),
    user_lname VARCHAR(100),
    profile_description text,
    profile_photo IMAGE,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_fname) REFERENCES Users (user_fname)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_lname) REFERENCES Users (user_lname)  ON DELETE CASCADE ON UPDATE CASCADE

);
CREATE TABLE Photos(
    photo_id VARCHAR(100),
    user_id VARCHAR(100),
    user_fname VARCHAR(100),
    user_lname VARCHAR(100),
    photo_name VARCHAR(100),
    photo_image IMAGE,
    photo_datetime DATETIME,
    PRIMARY KEY(photo_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_fname) REFERENCES Users (user_fname)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_lname) REFERENCES Users (user_lname)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Posts(
    post_id VARCHAR(100),
    user_id VARCHAR(100),
    user_fname VARCHAR(100),
    user_lname varchar(100),
    post_text text,
    post_datetime DATETIME,
    PRIMARY KEY (post_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_fname) REFERENCES Users (user_fname)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_lname) REFERENCES Users (user_lname)  ON DELETE CASCADE ON UPDATE CASCADE,
    
);
CREATE TABLE Groups(
    group_id VARCHAR(100),
    user_id VARCHAR(100),
    group_name VARCHAR(100),
    group_description text,
    PRIMARY KEY(group_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE GroupMembers(
    group_id VARCHAR(100),
    user_id VARCHAR(100),
    member_status VARCHAR(100),
    PRIMARY KEY(group_id,user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Friends(
    friend_id VARCHAR(100),
    user_id1 VARCHAR(100),
    user_id2 VARCHAR(100),
    friend_type VARCHAR(100),
    PRIMARY KEY(friend_id),
    FOREIGN KEY(user_id1) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_id2) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE GroupPosts(
    group_id VARCHAR(100),
    post_id VARCHAR(100),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Comments(
    comment_id VARCHAR(100),
    user_id VARCHAR(100),
    post_id VARCHAR(100),
    user_fname VARCHAR(100),
    user_lname VARCHAR(100),
    comment_text text,
    comment_datetime DATETIME,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_fname) REFERENCES Users (user_fname)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(user_lname) REFERENCES Users (user_lname)  ON DELETE CASCADE ON UPDATE CASCADE
    );
CREATE TABLE Guests(
    guest_id VARCHAR(100),
    guest_name VARCHAR(100),
    guest_email VARCHAR(100),
    guest_addr VARCHAR(100),
    guest_password VARCHAR (100),
    guest_telephone VARCHAR(100),
    PRIMARY KEY (guest_id)
);


GO
CREATE PROCEDURE CreateUser (@user_id VARCHAR(100),@user_fname VARCHAR(100), @user_lname VARCHAR(100),@user_email VARCHAR(100),@user_dob DATE,@user_tel INT(50),@user_addr VARCHAR(100), @user_password VARCHAR(100))
AS
INSERT INTO Users VALUES(@user_id,@user_fname,@user_lname,@user_dob,@user_password,@user_addr);
INSERT INTO Emails VALUES(@user_id,@user_email);
INSERT INTO Telephones VALUES(@user_id,@user_tel);
GO

CREATE PROCEDURE CreateProfile (@user_id VARCHAR(100),@user_fname VARCHAR(100),@user_lname VARCHAR(100),@profile_description text,@profile_photo IMAGE)
AS
INSERT INTO Profiles VALUES(@user_id,@user_fname,@user_lname,@profile_description,@profile_photo);
GO

CREATE PROCEDURE AddPhoto (@photo_id VARCHAR(100),@user_id VARCHAR(100),@user_fname VARCHAR(100),@user_lname VARCHAR(100),@photo_name VARCHAR(100),@photo_image IMAGE,@photo_datetime DATETIME)
AS
INSERT INTO Photos VALUES(@photo_id,@user_id,@user_fname,@user_lname,@photo_name,@photo_image,@photo_datetime);
GO

CREATE PROCEDURE AddPost (@post_id VARCHAR(100),@user_id VARCHAR(100),@user_fname VARCHAR(100),@user_lname varchar(100),@post_text text,@post_datetime DATETIME)
AS
INSERT INTO Posts VALUES(@post_id,@user_id,@user_fname,@user_lname,@post_text,@post_datetime);
GO

CREATE PROCEDURE AddComment(@comment_id VARCHAR(100),@user_id VARCHAR(100),@post_id VARCHAR(100),@user_fname VARCHAR(100),@user_lname VARCHAR(100),@comment_text text, @comment_datetime DATETIME)
AS
INSERT INTO Comment VALUES(@comment_id,@user_id,@post_id,@user_fname,@user_lname,@comment_text,@comment_datetime);
GO

CREATE PROCEDURE AddFriend (@friend_id VARCHAR(100),@user_id1 VARCHAR(100),@user_id2 VARCHAR(100),@friend_type VARCHAR(100))
AS
INSERT INTO Friends VALUES(@friend_id,@user_id1,@user_id2,@friend_type);
GO

CREATE PROCEDURE CreateGroup ( @group_id VARCHAR(100),@user_id VARCHAR(100),@group_name VARCHAR(100),@group_description text)
AS
INSERT INTO Groups VALUES(@group_id,@user_id,@group_name,@group_description);
GO

CREATE PROCEDURE AddGroupPost ( @group_id VARCHAR(100),@post_id VARCHAR)
AS
INSERT INTO GroupPosts VALUES(@group_id,@post_id);
GO

CREATE PROCEDURE AddGroupMembers ( @group_id VARCHAR(100),@user_id VARCHAR(100),@member_status VARCHAR(100))
AS
INSERT INTO GroupMembers VALUES(@group_id,@user_id,@member_status);
GO

CREATE PROCEDURE CreateGuests (@guest_id VARCHAR(100),@guest_name VARCHAR(100),@guest_email VARCHAR(100),@guest_addr VARCHAR(100),@guest_password VARCHAR (100),@guest_telephone VARCHAR(100))
AS
INSERT INTO GroupMembers VALUES(@guest_id,@guest_name,@guest_email,@guest_addr,@guest_password,@guest_telephone);
GO

CREATE PROCEDURE ViewUserProfile (@user_id VARCHAR(100))
AS
SELECT * FROM Profiles WHERE user_id=@user_id;
GO

CREATE PROCEDURE ViewUserPosts (@user_id VARCHAR(100))
AS
SELECT * FROM Posts WHERE user_id=@user_id;
GO

CREATE PROCEDURE ViewUserFriendsNames (@user_id VARCHAR(100))
AS
SELECT user_fname,user_lname FROM Users WHERE user_id IN (SELECT user_id2 FROM Friends WHERE user_id1=@user_id);
GO

CREATE VIEW [Posts] 
AS
SELECT * FROM Posts;

