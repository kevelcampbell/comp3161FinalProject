CREATE TABLE Users(
    user_id VARCHAR(100),
    user_f_name VARCHAR(100),
    user_l_name VARCHAR(100),
    user_dob DATE,
    user_password VARCHAR(100),
    user_addr VARCHAR(100), 
    PRIMARY KEY(user_id)
);
CREATE TABLE Emails(
    user_id VARCHAR(100),
    user_email VARCHAR(100),
    PRIMARY KEY(user_id,user_email)
);
CREATE TABLE Telephones(
    user_id VARCHAR(100),
    user_tel INT(50),
    PRIMARY KEY (user_id,user_tel)
);
CREATE TABLE Profiles(
    user_id VARCHAR(100),
    profile_description text,
    profile_photo BLOB,
    PRIMARY KEY(user_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Photos(
    photo_id VARCHAR(100),
    user_id VARCHAR(100),
    photo_name VARCHAR(100),
    photo_image BLOB,
    photo_datetime DATETIME,
    PRIMARY KEY(photo_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Posts(
    post_id VARCHAR(100),
    user_id VARCHAR(100),
    post_text text,
    post_datetime DATETIME,
    PRIMARY KEY (post_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
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
    user_id VARCHAR(100),
    friend_id VARCHAR(100),
    friend_type VARCHAR(100),
    PRIMARY KEY(user_id,friend_id),
    FOREIGN KEY(user_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(friend_id) REFERENCES Users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE GroupPosts(
    group_id VARCHAR(100),
    post_id VARCHAR(100),
    PRIMARY KEY (group_id,post_id),
    FOREIGN KEY(group_id) REFERENCES Groups (group_id)  ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Comments(
    comment_id VARCHAR(100),
    post_id VARCHAR(100),
    PRIMARY KEY (comment_id,post_id),
    FOREIGN KEY(comment_id) REFERENCES Posts(post_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts (post_id)  ON DELETE CASCADE ON UPDATE CASCADE
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



DELIMITTER //
CREATE PROCEDURE CreateUser (@user_id VARCHAR(100),@user_f_name VARCHAR(100), @user_l_name VARCHAR(100),@user_email VARCHAR(100),@user_dob DATE,@user_tel INT(50),@user_addr VARCHAR(100), @user_password VARCHAR(100))
BEGIN
    INSERT INTO Users VALUES(@user_id,@user_f_name,@user_l_name,@user_dob,@user_password,@user_addr);
    INSERT INTO Emails VALUES(@user_id,@user_email);
    INSERT INTO Telephones VALUES(@user_id,@user_tel);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE CreateProfile (@user_id VARCHAR(100),@profile_description text,@profile_photo IMAGE)
BEGIN
    INSERT INTO Profiles VALUES(@user_id,@profile_description,@profile_photo);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE AddPhoto (@photo_id VARCHAR(100),@user_id VARCHAR(100),@photo_name VARCHAR(100),@photo_image IMAGE,@photo_datetime DATETIME)
BEGIN
    INSERT INTO Photos VALUES(@photo_id,@user_id,@photo_name,@photo_image,@photo_datetime);
END //
DELIMITTER ;

DELIMITTER//
CREATE PROCEDURE AddPost (@post_id VARCHAR(100),@user_id VARCHAR(100),@post_text text,@post_datetime DATETIME)
BEGIN
    INSERT INTO Posts VALUES(@post_id,@user_id,@post_text,@post_datetime);
END //
DELIMITTER ;

DELIMITTER
CREATE PROCEDURE AddComment(@comment_id VARCHAR(100),@post_id VARCHAR(100))
BEGIN
    INSERT INTO Comments VALUES(@comment_id,@post_id);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE AddFriend (@user_id VARCHAR(100),@friend_id VARCHAR(100),@friend_type VARCHAR(100))
BEGIN
    INSERT INTO Friends VALUES(@user_id,@friend_id,@friend_type);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE CreateGroup ( @group_id VARCHAR(100),@user_id VARCHAR(100),@group_name VARCHAR(100),@group_description text)
BEGIN
    INSERT INTO Groups VALUES(@group_id,@user_id,@group_name,@group_description);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE AddGroupPost ( @group_id VARCHAR(100),@post_id VARCHAR)
BEGIN
    INSERT INTO GroupPosts VALUES(@group_id,@post_id);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE AddGroupMembers ( @group_id VARCHAR(100),@user_id VARCHAR(100),@member_status VARCHAR(100))
BEGIN
    INSERT INTO GroupMembers VALUES(@group_id,@user_id,@member_status);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE CreateGuests (@guest_id VARCHAR(100),@guest_name VARCHAR(100),@guest_email VARCHAR(100),@guest_addr VARCHAR(100),@guest_password VARCHAR (100),@guest_telephone VARCHAR(100))
BEGIN
    INSERT INTO GroupMembers VALUES(@guest_id,@guest_name,@guest_email,@guest_addr,@guest_password,@guest_telephone);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserFname (@user_id VARCHAR(100))
BEGIN
    SELECT user_f_name FROM Users WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserLname (@user_id VARCHAR(100))
BEGIN
    SELECT user_Lname FROM Users WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserDob (@user_id VARCHAR(100))
BEGIN
    SELECT user_dob FROM Users WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserPassword (@user_id VARCHAR(100))
BEGIN
    SELECT user_password FROM Users WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserAddress (@user_id VARCHAR(100))
BEGIN
    SELECT user_addr FROM Users WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserEmail (@user_id VARCHAR(100))
BEGIN
    SELECT user_email FROM Emails WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserTelephone (@user_id VARCHAR(100))
BEGIN
    SELECT user_tel FROM Telephones WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserProfile (@user_id VARCHAR(100))
BEGIN
    SELECT * FROM Profiles WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserPosts (@user_id VARCHAR(100))
BEGIN
    SELECT * FROM Posts WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserComments (@user_id VARCHAR(100))
BEGIN
    SELECT * FROM Posts WHERE post_id IN (SELECT comment_id FROM Comments WHERE user_id=@user_id);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserFriends (@user_id VARCHAR(100))
BEGIN
    SELECT * FROM Friends WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetFriendsPosts (@user_id VARCHAR(100),@friend_id VARCHAR(100))
BEGIN
    SELECT * FROM Posts WHERE user_id IN  (SELECT friend_id FROM Friends WHERE user_id=@user_id AND friend_id=@friend_id);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetUserFriendsNames (@user_id VARCHAR(100))
BEGIN
    SELECT user_f_name,user_l_name FROM Users WHERE user_id IN (SELECT friend_id FROM Friends WHERE user_id1=@user_id);
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE GetAllUsers_Friends_posts 
BEGIN
    SELECT * FROM Users INNER JOIN Friends ON Users.user_id=Friends.user_id INNER JOIN Posts ON Friends.user_id=Posts.user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE UpdateUserProfilePicture (@user_id VARCHAR(100),@profile_photo IMAGE)
BEGIN
    UPDATE Profiles SET profile_photo=@profile_photo WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE UpdateUserProfileDescription (@user_id VARCHAR(100),@profile_description TEXT)
BEGIN
    UPDATE Profiles SET profile_description=@profile_description WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE UpdateUserFirstName (@user_id VARCHAR(100),@user_f_name VARCHAR(100))
BEGIN
    UPDATE Users SET user_f_name=@user_f_name WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE PROCEDURE UpdateUserLastName (@user_id VARCHAR(100),@user_l_name VARCHAR(100))
BEGIN
    UPDATE Users SET user_l_name=@user_l_name WHERE user_id=@user_id;
END //
DELIMITTER ;

DELIMITTER //
CREATE VIEW [Posts] 
BEGIN
    SELECT * FROM Posts;
END //
DELIMITTER ;