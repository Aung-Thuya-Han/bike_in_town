-- This is a table where all the places/ locations in this game are put into.
-- And also x and y coordinates of each places so we can know its positon and calculate distance
-- between two points
CREATE TABLE places (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    x_coord FLOAT NOT NULL,
    y_coord FLOAT NOT NULL
);


-- This is for letting the player know what is happening in what places.
-- Player can get bonus, sometimes can lose some money to bully.
--  We can also know if the key is found or not according to this table.
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    money_change INT DEFAULT 0,
    energy_change INT DEFAULT 0,
    is_key BOOLEAN DEFAULT FALSE,
    is_bully BOOLEAN DEFAULT FALSE
);


-- This table is all about the player. How many energy or money has the player still left?
-- Has he or she found the key? What's the player name? What is the current place?
-- Such things are stored here.
CREATE TABLE game (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    money INT DEFAULT 50,
    energy FLOAT DEFAULT 50,
    current_place INT,
    key_found BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (current_place) REFERENCES places(id)
);


-- This table links game, places and the events. For example, you have met bully at library and he takes your money,
-- Then you unknowingly go back there again but this time you won't meet him. Because 'resolved' column adds the
-- memory that you have met bully at library. Same event doesn't happen at same location over and over again.
CREATE TABLE events_location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    event_id INT NOT NULL,
    place_id INT NOT NULL,
    resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (game_id) REFERENCES game(id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (place_id) REFERENCES places(id)
);


-- Inserting data to tables


-- Places in this game (30 total, Home at 5,5; all within 0–10 range)
-- As it is a simple, fun game, I do now wish to expand the map so large.
-- I believe in this playable area user can have fun.
INSERT INTO places (name, x_coord, y_coord) VALUES
('Home', 5, 5),
('Park', 2, 3),
('Mall', 8, 7),
('School', 10, 2),
('Beach', 1, 9),
('Library', 3, 10),
('Hospital', 7, 4),
('Stadium', 6, 6),
('Supermarket', 4, 8),
('Cinema', 9, 4),
('Restaurant', 2, 7),
('Cafe', 9, 9),
('Bank', 4, 6),
('Airport', 10, 10),
('Bus Station', 1, 2),
('Train Station', 7, 7),
('Hotel', 3, 9),
('Museum', 8, 2),
('Zoo', 6, 9),
('Amusement Park', 2, 5),
('Gym', 8, 3),
('Pharmacy', 10, 8),
('Factory', 6, 2),
('Warehouse', 5, 9),
('Harbor', 9, 6),
('University', 2, 8),
('Police Station', 7, 10),
('Fire Station', 4, 4),
('Office', 3, 6),
('Tower', 10, 3);

-- Events happening across the town. Sometimes you can be lucky, but sometimes you aren't.
-- Finding the key is also an event so it is in this table.
INSERT INTO events (name, money_change, energy_change, is_key, is_bully) VALUES
('Found $10', 10, 0, FALSE, FALSE),
('Found $20', 20, 0, FALSE, FALSE),
('Found Energy Drinks', 0, 20, FALSE, FALSE),
('Bully steals half your money', 0, 0, FALSE, TRUE),
('You found the hidden key!', 0, 0, TRUE, FALSE);

-- Player information. If the player gets money, it is added in here. If player loses money, it updates here too.
INSERT INTO game (player_name, money, energy, current_place)
VALUES ('Aung', 20, 20, 1);

-- Adding events to the town, like where the key is, where the energy drink is.
-- Events could be at random places but they won't happen at the same place twice.
INSERT INTO events_location (game_id, event_id, place_id, resolved) VALUES
(1, 1, 2, FALSE), -- Found $10 at Park
(1, 2, 3, FALSE), -- Found $20 at Mall
(1, 3, 4, FALSE), -- Energy Drink at School
(1, 4, 5, FALSE), -- Bully at Beach
(1, 5, 3, FALSE); -- Key at Mall
