/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Agumon',
    'Feb 3, 2020',
    10.23,
    true,
    0
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Gabumon',
    'Nov 15, 2018',
    8,
    true,
    2
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Pikachu',
    'Jan 7, 2021',
    15.04,
    false,
    1
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Devimon',
    'May 12, 2017',
    11,
    true,
    5
);


/* Update and Query animals table */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Charmander',
    'Feb 8, 2020',
    -11,
    false,
    0
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Plantmon',
    'Nov 15, 2022',
    -5.7,
    true,
    2
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Squirtle',
    'Apr 2, 1993',
    -12.13,
    false,
    3
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Angemon',
    'Jun 12, 2005',
    -45,
    true,
    1
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Boarmon',
    'Jun 7, 2005',
    20.4,
    true,
    7
);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (
    'Blossom',
    'Oct 13, 1998',
    17,
    true,
    3
);

/* Query multiple tables */

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

BEGIN TRANSACTION;
UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE species_id IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
UPDATE animals SET owner_id = 1 WHERE name LIKE 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');
COMMIT TRANSACTION;