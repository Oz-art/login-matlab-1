clear all

% data = readtable('user_database.csv');

opts = detectImportOptions('user_database2.csv','TextType','string')
T = readtable('user_database2.csv',opts)