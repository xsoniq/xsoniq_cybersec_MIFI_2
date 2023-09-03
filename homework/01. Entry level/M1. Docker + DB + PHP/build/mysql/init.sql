CREATE DATABASE IF NOT EXISTS music;
CREATE USER IF NOT EXISTS 'root'@'172.27.0.3' 
IDENTIFIED BY 'admin';
GRANT ALL ON music.* TO 'root'@'172.27.0.3';
FLUSH PRIVILEGES;

USE 'music';

CREATE TABLE IF NOT EXISTS MusicDownloadsTable (
  musicstyle VARCHAR(100) NOT NULL, 
  trackname VARCHAR(50) NOT NULL, 
  downloads INT (10) NOT NULL);

INSERT INTO MusicDownloadsTable (musicstyle, trackname, downloads) 
VALUES 
  (
    'Psy-midtempo', 'Alterra Project - The Archive', 
    '850678'
  ), 
  (
    'Neuro-bass', 'Metrik - Hackers', 
    '230500'
  ), 
  (
    'Dubstep', 'Famous Spear - XODUS', 
    '63566'
  );
