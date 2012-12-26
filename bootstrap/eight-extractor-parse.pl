#!/usr/bin/perl
use strict;
use warnings;
use DBI;
#use SQLite;
use JSON;
use Data::Dumper;

my $j_parse = new JSON;
$j_parse->utf8(1);

my $match = qr/\[\[Script "eight extractor" version [^\]]+\]\]: (.+)/;

while ( my $line = <STDIN> ) {
    chomp $line;
    my ($payload) = $line =~ $match;
    next unless $payload;
    my $galaxy = $j_parse->decode( $payload );
    print "Got galaxy " . Dumper $galaxy;
}
