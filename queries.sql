/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT * from animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 and 2019;