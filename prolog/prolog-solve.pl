#!/usr/bin/perl
use strict;
use lib 'lib';
use OoliteDB;
use Data::Dumper;
use Language::Prolog::Interpreter;

my $prolog = Language::Prolog::Interpreter->readFile('planets.prolog');
die $prolog;

my $planets = OoliteDB::Planet->select('where galaxy=0');


foreach my $p (@$planets) {
    my $eco = OoliteDB::Economy->load( $p->economy );
    my $gov = OoliteDB::Government->load( $p->government );

    my @pdesc = split /\s/, lc $p->description;
    my @eco_desc = split /\s/, lc $eco->economy_description;
    my @gov_desc = split /\s/, lc $gov->government_description;

print Dumper [ \@pdesc,\@eco_desc,\@gov_desc ];

}
