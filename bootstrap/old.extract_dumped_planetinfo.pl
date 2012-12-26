#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';
use JSON 'decode_json';
use DBI;
use OoliteDB;
use Data::Dumper;

my @planet_keys = qw(
	economy government techlevel name description
	inhabitants population radius productivity
);

while (<STDIN>) {
    next unless $_ =~ /Galaxy info dumper/;
    my ($json) = $_ =~ /Galaxy info dumper\]:(.+)$/;
    my $data = eval {  decode_json $json; };
    next unless $data;

    my ($x,$y) = $data->{coord} =~ /(\d+)\s+(\d+)/;
    my %rec;
    $rec{$_} = $data->{$_} for @planet_keys;
    $rec{planet} = $data->{planetnum};
    $rec{galaxy} = $data->{galnum};
    $rec{xcoord} = $x;
    $rec{ycoord} = $y;
    eval { OoliteDB::Planet->new(%rec)->insert; }

}

