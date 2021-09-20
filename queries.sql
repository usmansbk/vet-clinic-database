/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT name from animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 and 2019;

SELECT name from animals WHERE neutered IS TRUE AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered IS TRUE;

SELECT * from animals WHERE name NOT LIKE 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;