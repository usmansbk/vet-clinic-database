/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT name from animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 and 2019;

SELECT name from animals WHERE neutered IS TRUE AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered IS TRUE;

SELECT * from animals WHERE name NOT LIKE 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Query and Update animal table */
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT DELETE_DATE; 
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO DELETE_DATE;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT TRANSACTION;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT neutered, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY neutered;
SELECT neutered, AVG(escape_attempts) FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY neutered;

/* Query multiple tables */
