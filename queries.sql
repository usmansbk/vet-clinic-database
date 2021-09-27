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

SELECT animals.name, owners.full_name FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    AND owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals
    INNER JOIN species
    ON species.id = animals.species_id
    AND species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners
    LEFT JOIN animals
    ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) FROM animals
    FULL OUTER JOIN species
    ON species.id = animals.species_id
    GROUP BY species.id;

SELECT animals.name, species.name FROM animals
    INNER JOIN owners ON owners.id = animals.owner_id
    INNER JOIN species ON species.id = animals.species_id
    WHERE owners.full_name = 'Jennifer Orwell'
    AND species.name = 'Digimon';

SELECT animals.name, animals.escape_attempts FROM animals
    INNER JOIN owners ON owners.id = animals.owner_id
    WHERE owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.owner_id) FROM animals 
    FULL OUTER JOIN owners 
    ON animals.owner_id = owners.id
    GROUP BY owners.id;

/* Add "join table" for visits */

SELECT animals.name, visits.date_of_visit AS last_visit FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'William Tatcher'
    GROUP BY animals.name, visits.date_of_visit
    ORDER BY last_visit DESC LIMIT 1;

SELECT COUNT(DISTINCT visits.animals_id) FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets 
    LEFT JOIN specialization ON specialization.vets_id = vets.id
    LEFT JOIN species ON species.id = specialization.species_id;

SELECT animals.name, visits.date_of_visit FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'Stephanie Mendez'
    AND visits.date_of_visit BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020';

SELECT animals.name, COUNT(visits.animals_id) AS visit_count FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    GROUP BY animals.name, visits.animals_id
    ORDER BY visit_count DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit AS first_visit FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY animals.name, visits.date_of_visit
    ORDER BY first_visit LIMIT 1;

SELECT * FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.animals_id) FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    INNER JOIN specialization ON specialization.vets_id = vets.id
    WHERE specialization.species_id <> animals.species_id;

SELECT species.name, COUNT(visits.animals_id) AS species_count FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    INNER JOIN species ON species.id = animals.species_id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name
    ORDER BY species_count DESC LIMIT 1;

/* Performace Audit */

explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;
explain analyze SELECT * FROM visits where vets_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';