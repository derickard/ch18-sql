create table plant (
plant_id int primary key auto_increment,
plant_name VARCHAR(120),
zone int,
season varchar(120)
);

create table seeds (
seed_id int primary key auto_increment,
expiration_date date,
quantity int,
reorder boolean,
plant_id int,
foreign key (plant_id) REFERENCES plant(plant_id)
);

create table garden_bed (
space_number int primary key auto_increment,
date_planted date,
doing_well boolean,
plant_id int,
Foreign key (plant_id) REFERENCES plant(plant_id)
);


select plant_name from plant inner join seeds on plant.plant_id = seeds.plant_id;

select plant_name from plant inner join garden_bed on plant.plant_id = garden_bed.plant_id;

select plant_name AS "Have seeds for and in garden bed" from plant where plant_id IN (select seeds.plant_id from seeds inner join garden_bed on seeds.plant_id = garden_bed.plant_id);

select plant_name from plant where plant_id IN (select seeds.plant_id from seeds left join garden_bed on seeds.plant_id = garden_bed.plant_id);

select plant_name from plant where plant_id IN (select seeds.plant_id from seeds right join garden_bed on seeds.plant_id = garden_bed.plant_id);

select plant_name from plant where plant_id IN (select seeds.plant_id from seeds left join garden_bed on seeds.plant_id = garden_bed.plant_id)
union
select plant_name from plant where plant_id IN (select seeds.plant_id from seeds right join garden_bed on seeds.plant_id = garden_bed.plant_id);


insert into seeds (expiration_date, quantity, reorder, plant_id)
values ('2020-08-05', 100, 0, (SELECT plant_id FROM plant WHERE (plant_name LIKE 'Hosta') ));