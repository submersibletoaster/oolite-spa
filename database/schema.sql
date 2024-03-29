PRAGMA foreign_keys=on;


create table economy (
	economy integer primary key,
	economy_description string
);

insert into economy values(0,'Rich Industrial');
insert into economy values(1,'Average Industrial');
insert into economy values(2,'Poor Industrial');
insert into economy values(3,'Mainly Industrial');
insert into economy values(4,'Mainly Agricultural');
insert into economy values(5,'Rich Agricultural');
insert into economy values(6,'Average Agricultural');
insert into economy values(7,'Poor Agricultural');


create table galaxy (
	galaxy integer primary key,
	galaxy_description string
);
insert into galaxy values(0,'Galaxy 1');
insert into galaxy values(1,'Galaxy 2');
insert into galaxy values(2,'Galaxy 3');
insert into galaxy values(3,'Galaxy 4');
insert into galaxy values(4,'Galaxy 5');
insert into galaxy values(5,'Galaxy 6');
insert into galaxy values(6,'Galaxy 7');
insert into galaxy values(7,'Galaxy 8');

create table government (
	government integer primary key,
	government_description string
);

insert into government values(0,'Anarchy');
insert into government values(1,'Feudal');
insert into government values(2,'Multi-Government');
insert into government values(3,'Dictatorship');
insert into government values(4,'Communist');
insert into government values(5,'Confederacy');
insert into government values(6,'Democracy');
insert into government values(7,'Corporate State');

create table system (
	system integer not null,
	galaxy integer not null,
	economy integer not null,
	government integer not null,
	techlevel integer not null,
	name,
	description,
	inhabitants,
	population integer ,
	radius integer ,
	productivity,
	xcoord number ,
	ycoord number ,
	primary key (galaxy,system) ,
	foreign key(galaxy) references galaxy(galaxy) ,
	foreign key(economy) references economy(economy) ,
	foreign key(government) references government(government)
);

/*
{
	"population":49,
	"stations_require_docking_clearance":"no",
	"star_count_multiplier":2,
	"economy":0,
	"planetnum":254,
	"inhabitants":"Human Colonials",
	"name":"Onlema",
"galnum":0,
"techlevel":11,
"corona_flare":0.07500000000000001,
"government":4,
"coord":"(55.2, 49.6, 0)",
"productivity":31360,
"radius":6794,
"description":"This world is plagued by frequent solar activity.",
"inhabitant":"Human Colonial",
"nebula_count_multiplier":1}


*/

create table user (
	user integer PRIMARY KEY AUTOINCREMENT,
	username string UNIQUE,
	email string NOT NULL,
	password string NOT NULL
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) DEFAULT NULL,
    login VARCHAR(255) NOT NULL,
    password TEXT NOT NULL,
    roles TEXT
);


create table my_system_description (
	my_system_description integer PRIMARY KEY AUTOINCREMENT,
	owner integer NOT NULL,
	galaxy integer NOT NULL,
	system integer NOT NULL,
	description string,
	generation number NOT NULL,
	updated integer NOT NULL DEFAULT (strftime('%s','now')),
	CONSTRAINT my_system_description_unique
		UNIQUE(owner,galaxy,system,generation),
	FOREIGN KEY(owner) REFERENCES user(user),
	FOREIGN KEY(galaxy) REFERENCES galaxy(galaxy)	
);

create table my_system_mainplanet (
	my_system_mainplanet integer PRIMARY KEY AUTOINCREMENT,
	owner integer NOT NULL,
	generation integer NOT NULL,
	galaxy integer NOT NULL,
	system integer NOT NULL,
	updated integer NOT NULL DEFAULT (strftime('%s','now')),
	
	CONSTRAINT my_system_mainplanet_unique
		UNIQUE (owner,generation,galaxy,system),
	FOREIGN KEY(owner) REFERENCES user(user),
	FOREIGN KEY(galaxy) REFERENCES galaxy(galaxy)
);

create table my_galaxy (
	owner integer NOT NULL,
	galaxy integer NOT NULL,
	description string,
	generation number NOT NULL,
	updated integer NOT NULL DEFAULT (strftime('%s','now')),
	CONSTRAINT my_galaxy_uniq
		UNIQUE (owner,galaxy,generation),
	FOREIGN KEY(owner) REFERENCES user(user),
	FOREIGN KEY(galaxy) REFERENCES galaxy(galaxy)
);




