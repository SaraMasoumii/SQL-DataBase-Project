CREATE TABLE ProductCategory (
    ProductCategoryID INTEGER PRIMARY KEY,
    Name TEXT
);
CREATE TABLE ObjectCategory (
    ObjectCategoryID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE ScapeRoomCategory (
    ScapeRoomCategoryID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE BoardGameCategory (
    BoardGameCategoryID INTEGER PRIMARY KEY,
    Name TEXT
);
CREATE TABLE EventCategory (
    EventCategoryID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE TransactionState (
    TransactionStateID INTEGER PRIMARY KEY,
    Name TEXT
);
CREATE TABLE ScapeRoomLevel (
    ScapeRoomLevelID INTEGER PRIMARY KEY,
    Name TEXT
);
-- 22) Order State
CREATE TABLE OrderState (
    OrderStateID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE City (
    CityID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE Role (
    RoleID INTEGER PRIMARY KEY,
    Name TEXT
);

-- 16) Provider
CREATE TABLE Provider (
    ProviderID INTEGER PRIMARY KEY,
    Name TEXT
);
CREATE TABLE Location (
    LocationID INTEGER PRIMARY KEY,
    X REAL,
    Y REAL
);
CREATE TABLE Userr (
    UserID INTEGER PRIMARY KEY,
    NickName TEXT,
    Email TEXT,
    PhoneNumber TEXT,
    Birthday TEXT,
    EmailConfirmed INTEGER,
    Gender TEXT
);
CREATE TABLE Object (
    ObjectID INTEGER PRIMARY KEY,
    Price REAL,
    CreatedDate datetime,
    ObjectCategoryID INTEGER,
    DiscountPercent REAL,
    VideoLink TEXT,
    FOREIGN KEY (ObjectCategoryID) REFERENCES ObjectCategory(ObjectCategoryID)
);
CREATE TABLE BoardGame (
    BoardGameID INTEGER PRIMARY KEY,
    About TEXT,
    GameRules TEXT,
    ProviderID INTEGER,
    ObjectID INTEGER,
    MinAge INTEGER,
    ParticipantRange TEXT,
    Duration INTEGER,
    Difficulty TEXT,
    AvailableCount INTEGER,
    FOREIGN KEY (ProviderID) REFERENCES Provider(ProviderID),
    FOREIGN KEY (ObjectID) REFERENCES Object(ObjectID)
);
CREATE TABLE BoardGameBoardGameCategory (
    BoardGameID INTEGER,
    BoardGameCategoryID INTEGER,
    PRIMARY KEY (BoardGameID, BoardGameCategoryID),
    FOREIGN KEY (BoardGameID) REFERENCES BoardGame(BoardGameID),
    FOREIGN KEY (BoardGameCategoryID) REFERENCES BoardGameCategory(BoardGameCategoryID)
);
CREATE TABLE Address (
    AddressID INTEGER PRIMARY KEY,
    CityID INTEGER,
    Description TEXT,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);
CREATE TABLE Center (
    CenterID INTEGER PRIMARY KEY,
    LocationID INTEGER,
    ProviderID INTEGER,
    AddressID INTEGER,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
    FOREIGN KEY (ProviderID) REFERENCES Provider(ProviderID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

CREATE TABLE ScapeRoom (
    ScapeRoomID INTEGER PRIMARY KEY,
    About TEXT,
    GameStory TEXT,
    CenterID INTEGER,
    ObjectID INTEGER,
    ContactInfo TEXT,
    MinAge INTEGER,
    ParticipantRange TEXT,
    Duration INTEGER,
    Difficulty TEXT,
    ScapeRoomLevelID INTEGER,
    FOREIGN KEY (CenterID) REFERENCES Center(CenterID),
    FOREIGN KEY (ObjectID) REFERENCES Object(ObjectID),
    FOREIGN KEY (ScapeRoomLevelID) REFERENCES ScapeRoomLevel(ScapeRoomLevelID)
);

CREATE TABLE Event (
    EventID INTEGER PRIMARY KEY,
    About TEXT,
    GameStory TEXT,
    CenterID INTEGER,
    ObjectID INTEGER,
    ContactInfo TEXT,
    MinAge INTEGER,
    ParticipantRange TEXT,
    Duration INTEGER,
    Difficulty TEXT,
    FOREIGN KEY (CenterID) REFERENCES Center(CenterID),
    FOREIGN KEY (ObjectID) REFERENCES Object(ObjectID)
);


CREATE TABLE OnlineGame (
    OnlineGameID INTEGER PRIMARY KEY,
    About TEXT,
    GameStory TEXT,
    ProviderID INTEGER,
    ObjectID INTEGER,
    ContactInfo TEXT,
    MinAge INTEGER,
    ParticipantRange TEXT,
    Duration INTEGER,
    Difficulty TEXT,
    FOREIGN KEY (ProviderID) REFERENCES Provider(ProviderID),
    FOREIGN KEY (ObjectID) REFERENCES Object(ObjectID)
);
CREATE TABLE Review (
    ReviewID INTEGER PRIMARY KEY,
    UserID INTEGER,
    ReviewDate datetime,
    Content TEXT,
    ObjectID INTEGER,
    Score INTEGER,
    NickName TEXT,
    FOREIGN KEY (UserID) REFERENCES Userr(UserID),
    FOREIGN KEY (ObjectID) REFERENCES Object(ObjectID)
);
CREATE TABLE orderr (
    OrderID INTEGER PRIMARY KEY,
    OrderStateID INTEGER,
    UserID INTEGER,
    CreatedDateTime datetime,
    FinalPrice REAL,
    FOREIGN KEY (OrderStateID) REFERENCES OrderState(OrderStateID),
    FOREIGN KEY (UserID) REFERENCES Userr(UserID)
);
CREATE TABLE Transactionn (
    TransactionID INTEGER PRIMARY KEY,
    CreatedDate datetime,
    UserID INTEGER,
    HashCode TEXT,
    OrderID INTEGER,
    TransactionAmount REAL,
    TransactionStateID INTEGER,
    FOREIGN KEY (UserID) REFERENCES Userr(UserID),
    FOREIGN KEY (OrderID) REFERENCES Orderr(OrderID),
    FOREIGN KEY (TransactionStateID) REFERENCES TransactionState(TransactionStateID)
);
CREATE TABLE Author (
    AuthorID INTEGER PRIMARY KEY,
    Name TEXT,
    Bio TEXT,
    UserID INTEGER,
    FOREIGN KEY (UserID) REFERENCES Userr(UserID)
);

CREATE TABLE Articles (
    ArticleID INTEGER PRIMARY KEY,
    AuthorID INTEGER,
    Description TEXT,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);


CREATE TABLE Discount (
    DiscountID INTEGER PRIMARY KEY,
    UserID INTEGER,
    ExpireDateTime datetime,
    DiscountPercent REAL,
    MaxPrice REAL,
    DiscountCode TEXT,
    FOREIGN KEY (UserID) REFERENCES Userr(UserID)
);

CREATE TABLE Product (
    ProductID INTEGER PRIMARY KEY,
    Price REAL,
    ProductCategoryID INTEGER,
    SalableID INTEGER,
    FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)
);
CREATE TABLE ProductOrder (
    OrderID INTEGER,
    ProductID INTEGER,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orderr(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



CREATE TABLE ScapeRoomScapeRoomCategory (
    ScapeRoomID INTEGER,
    ScapeRoomCategoryID INTEGER,
    PRIMARY KEY (ScapeRoomID, ScapeRoomCategoryID),
    FOREIGN KEY (ScapeRoomID) REFERENCES ScapeRoom(ScapeRoomID),
    FOREIGN KEY (ScapeRoomCategoryID) REFERENCES ScapeRoomCategory(ScapeRoomCategoryID)
);

CREATE TABLE EventEventCategory (
    EventID INTEGER,
    EventCategoryID INTEGER,
    PRIMARY KEY (EventID, EventCategoryID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (EventCategoryID) REFERENCES EventCategory(EventCategoryID)
);

CREATE TABLE Sans (
    SansID INTEGER PRIMARY KEY,
    DateTime datetime,
    ObjectID INTEGER,
    IsReserved INTEGER,
    FOREIGN KEY (ObjectID) REFERENCES Object(ObjectID)
);


CREATE TABLE Reservation (
    ReservationID INTEGER PRIMARY KEY,
    NumberOfPlayers INTEGER,
    SansID INTEGER,
    UserID INTEGER,
    FOREIGN KEY (SansID) REFERENCES Sans(SansID),
    FOREIGN KEY (UserID) REFERENCES Userr(UserID)
);

CREATE TABLE ConfirmationCode (
    ConfirmationCodeID INTEGER PRIMARY KEY,
    Code TEXT,
    UserID INTEGER,
    ExpireDateTime datetime,
    FOREIGN KEY (UserID) REFERENCES Userr(UserID)
);

CREATE TABLE UserRole (
    RoleID INTEGER,
    UserID INTEGER,
    PRIMARY KEY (RoleID, UserID),
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
    FOREIGN KEY (UserID) REFERENCES Userr(UserID)
);


INSERT INTO ProductCategory (ProductCategoryID, Name) VALUES
    (1, 'Electronics'),
    (2, 'Clothing'),
    (3, 'Books');

INSERT INTO ObjectCategory (ObjectCategoryID, Name) VALUES
    (1, 'Gadgets'),
    (2, 'Accessories'),
    (3, 'Home Appliances');

INSERT INTO ScapeRoomCategory (ScapeRoomCategoryID, Name) VALUES
    (1, 'Horror'),
    (2, 'Adventure'),
    (3, 'Mystery');

INSERT INTO BoardGameCategory (BoardGameCategoryID, Name) VALUES
    (1, 'Strategy'),
    (2, 'Party'),
    (3, 'Cooperative');

INSERT INTO EventCategory (EventCategoryID, Name) VALUES
    (1, 'Concerts'),
    (2, 'Festivals'),
    (3, 'Workshops');

INSERT INTO TransactionState (TransactionStateID, Name) VALUES
    (1, 'Pending'),
    (2, 'Completed'),
    (3, 'Cancelled');

INSERT INTO ScapeRoomLevel (ScapeRoomLevelID, Name) VALUES
    (1, 'Beginner'),
    (2, 'Intermediate'),
    (3, 'Advanced');

INSERT INTO OrderState (OrderStateID, Name) VALUES
    (1, 'Processing'),
    (2, 'Shipped'),
    (3, 'Delivered');

INSERT INTO City (CityID, Name) VALUES
    (1, 'New York'),
    (2, 'Los Angeles'),
    (3, 'Chicago');

INSERT INTO Role (RoleID, Name) VALUES
    (1, 'Admin'),
    (2, 'User'),
    (3, 'Moderator');

INSERT INTO Provider (ProviderID, Name) VALUES
    (1, 'Electronics Inc.'),
    (2, 'Fashion House'),
    (3, 'Book Emporium');

INSERT INTO Location (LocationID, X, Y) VALUES
    (1, 40.7128, -74.0060),
    (2, 34.0522, -118.2437),
    (3, 41.8781, -87.6298);

INSERT INTO Userr (UserID, NickName, Email, PhoneNumber, Birthday, EmailConfirmed, Gender) VALUES
    (1, 'JohnDoe', 'mailto:john@example.com', '1234567890', '1990-01-01', 1, 'Male'),
    (2, 'JaneSmith', 'mailto:jane@example.com', '9876543210', '1995-05-15', 1, 'Female'),
    (3, 'AliceWonderland', 'mailto:alice@example.com', '5555555555', '1988-12-25', 1, 'Female');

INSERT INTO Object (ObjectID, Price, CreatedDate, ObjectCategoryID, DiscountPercent, VideoLink) VALUES
    (1, 99.99, '2024-02-12', 1, 0, 'https://www.example.com/video1'),
    (2, 49.99, '2024-02-13', 2, 10, 'https://www.example.com/video2'),
    (3, 199.99, '2024-02-14', 3, 5, 'https://www.example.com/video3');

INSERT INTO BoardGame (BoardGameID, About, GameRules, ProviderID, ObjectID, MinAge, ParticipantRange, Duration, Difficulty, AvailableCount) VALUES
    (1, 'Strategy game', 'Rules for the game', 1, 1, 12, '2-4 players', 60, 'Medium', 100),
    (2, 'Party game', 'Rules for the game', 2, 2, 8, '3-6 players', 30, 'Easy', 50),
    (3, 'Cooperative game', 'Rules for the game', 3, 3, 10, '1-4 players', 90, 'Hard', 75);

INSERT INTO Address (AddressID, CityID, Description) VALUES
    (1, 1, 'Address 1, City 1'),
    (2, 2, 'Address 2, City 2'),
    (3, 3, 'Address 3, City 3');
INSERT INTO Center (CenterID, LocationID, ProviderID, AddressID) VALUES
    (1, 1, 1, 1),
    (2, 2, 2, 2),
    (3, 3, 3, 3);

INSERT INTO ScapeRoom (ScapeRoomID, About, GameStory, CenterID, ObjectID, ContactInfo, MinAge, ParticipantRange, Duration, Difficulty, ScapeRoomLevelID) VALUES
    (1, 'Horror-themed escape room', 'Storyline for the game', 1, 1, 'mailto:contact@example.com', 16, '2-6 players', 60, 'Medium', 2),
    (2, 'Adventure-themed escape room', 'Storyline for the game', 2, 2, 'mailto:contact@example.com', 12, '3-8 players', 45, 'Easy', 1),
    (3, 'Mystery-themed escape room', 'Storyline for the game', 3, 3, 'mailto:contact@example.com', 18, '2-4 players', 75, 'Hard', 3);

INSERT INTO Event (EventID, About, GameStory, CenterID, ObjectID, ContactInfo, MinAge, ParticipantRange, Duration, Difficulty) VALUES
    (1, 'Concert', 'Description of the event', 1, 1, 'mailto:contact@example.com', 18, '50-100 participants', 120, 'Medium'),
    (2, 'Workshop', 'Description of the event', 2, 2, 'mailto:contact@example.com', 16, '20-30 participants', 90, 'Easy'),
    (3, 'Festival', 'Description of the event', 3, 3, 'mailto:contact@example.com', 21, '1000-2000 participants', 180, 'Hard');

INSERT INTO OnlineGame (OnlineGameID, About, GameStory, ProviderID, ObjectID, ContactInfo, MinAge, ParticipantRange, Duration, Difficulty) VALUES
    (1, 'Online strategy game', 'Description of the game', 1, 1, 'mailto:contact@example.com', 18, 'Single player', 60, 'Medium'),
    (2, 'Online multiplayer game', 'Description of the game', 2, 2, 'mailto:contact@example.com', 14, 'Multiplayer', 45, 'Easy'),
    (3, 'Online cooperative game', 'Description of the game', 3, 3, 'mailto:contact@example.com', 16, '2-4 players', 90, 'Hard');

INSERT INTO Review (ReviewID, UserID, ReviewDate, Content, ObjectID, Score, NickName) VALUES
    (1, 1, '2024-02-12', 'Great product!', 1, 5, 'John'),
    (2, 2, '2024-02-13', 'Good experience overall', 2, 4, 'Jane'),
    (3, 3, '2024-02-14', 'Could be better', 3, 3, 'Alice');

INSERT INTO orderr (OrderID, OrderStateID, UserID, CreatedDateTime, FinalPrice) VALUES
    (1, 1, 1, '2024-02-12', 99.99),
    (2, 2, 2, '2024-02-13', 49.99),
    (3, 3, 3, '2024-02-14', 199.99);

INSERT INTO Transactionn (TransactionID, CreatedDate, UserID, HashCode, OrderID, TransactionAmount, TransactionStateID) VALUES
    (1, '2024-02-12', 1, 'hash1', 1, 99.99, 2),
    (2, '2024-02-13', 2, 'hash2', 2, 49.99, 2),
    (3, '2024-02-14', 3, 'hash3', 3, 199.99, 2);

INSERT INTO Author (AuthorID, Name, Bio, UserID) VALUES
    (1, 'John Doe', 'Author bio', 1),
    (2, 'Jane Smith', 'Author bio', 2),
    (3, 'Alice Wonderland', 'Author bio', 3);

INSERT INTO Articles (ArticleID, AuthorID, Description) VALUES
    (1, 1, 'Article about topic'),
    (2, 2, 'Article about topic'),
    (3, 3, 'Article about topic');

INSERT INTO Discount (DiscountID, UserID, ExpireDateTime, DiscountPercent, MaxPrice, DiscountCode) VALUES
    (1, 1, '2024-03-01', 10, 100, 'DISCOUNT10'),
    (2, 2, '2024-03-01', 15, 50, 'DISCOUNT15'),
    (3, 3, '2024-03-01', 5, 200, 'DISCOUNT5');

INSERT INTO Product (ProductID, Price, ProductCategoryID, SalableID) VALUES
    (1, 99.99, 1, 1),
    (2, 49.99, 2, 2),
    (3, 199.99, 3, 3);

INSERT INTO ProductOrder (OrderID, ProductID) VALUES
    (1, 1),
    (2, 2),
    (3, 3);



INSERT INTO ScapeRoomScapeRoomCategory (ScapeRoomID, ScapeRoomCategoryID) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO EventEventCategory (EventID, EventCategoryID) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO Sans (SansID, DateTime, ObjectID, IsReserved) VALUES
    (1, '2024-02-12', 1, 0),
    (2, '2024-02-13', 2, 1),
    (3, '2024-02-14', 3, 0);

INSERT INTO Reservation (ReservationID, NumberOfPlayers, SansID, UserID) VALUES
    (1, 4, 1, 1),
    (2, 3, 2, 2),
    (3, 2, 3, 3);

INSERT INTO ConfirmationCode (ConfirmationCodeID, Code, UserID, ExpireDateTime) VALUES
    (1, 'CONFIRM1', 1, '2024-03-01'),
    (2, 'CONFIRM2', 2, '2024-03-01'),
    (3, 'CONFIRM3', 3, '2024-03-01');

INSERT INTO UserRole (RoleID, UserID) VALUES
    (1, 1),
    (2, 2),
    (3, 3);


SELECT DISTINCT u.UserID, u.NickName, u.Email
FROM Userr u
JOIN Review r ON u.UserID = r.UserID
WHERE r.Score < 3


SELECT sc.Name AS Genre, AVG(r.Score) AS AvgScore
FROM ScapeRoom s
JOIN ScapeRoomScapeRoomCategory src ON s.ScapeRoomID = src.ScapeRoomID
JOIN ScapeRoomCategory sc ON src.ScapeRoomCategoryID = sc.ScapeRoomCategoryID
JOIN Review r ON s.ObjectID = r.ObjectID
GROUP BY sc.Name
HAVING AVG(r.Score) = (
    SELECT MAX(AvgScore)
    FROM (
        SELECT AVG(r.Score) AS AvgScore
        FROM ScapeRoom s
        JOIN ScapeRoomScapeRoomCategory src ON s.ScapeRoomID = src.ScapeRoomID
        JOIN Review r ON s.ObjectID = r.ObjectID
        GROUP BY src.ScapeRoomCategoryID
    ) AS Subquery
);



SELECT p.ProductID, COUNT(po.OrderID) AS NumSales
FROM Product p
JOIN ProductOrder po ON p.ProductID = po.ProductID
GROUP BY p.ProductID
ORDER BY NumSales DESC
LIMIT 1;


SELECT * FROM Discount
WHERE UserID = 4;

SELECT o.OrderID, COUNT(po.ProductID) as TotalProducts
FROM Orderr o
JOIN ProductOrder po ON o.OrderID = po.OrderID
GROUP BY o.OrderID;


SELECT p.ProductID, SUM(p.price) AS TotalRevenue
FROM Product p
JOIN ProductOrder po ON p.ProductID = po.ProductID
GROUP BY p.ProductID
ORDER BY TotalRevenue DESC
LIMIT 1;



SELECT c.CenterID, a.Description AS Address
FROM Center c
JOIN Address a ON c.AddressID = a.AddressID
WHERE a.CityID = (SELECT CityID FROM City WHERE Name = 'YourCityName');

SELECT  u.UserID, u.NickName
FROM Userr u
JOIN Orderr o ON u.UserID = o.UserID
LEFT JOIN Review r ON u.UserID = r.UserID
WHERE r.UserID IS NULL;

# select * from userr where userr.userid not  in (
# select userid from orderr where createddatetime >= DATEADD(YEAR, -1, GETDATE())
# )

select * from scaperoom where scaperoomid in (
select scaperoomid from scaperoom s  join review r on s.objectid = r.objectid
group by scaperoomid
having AVG(score) > 3
)

select * from userr where userid in (
select u.userid from userr u join orderr o on u.userid = o.userid group by u.userid
having sum(finalprice) > 1000000
)
