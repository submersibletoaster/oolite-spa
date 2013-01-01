#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use JSON;
use Data::Dumper;

my $db =  DBI->connect("dbi:SQLite:dbname=oolite.db","","");
#$db->trace(2);

my $sys_insert = $db->prepare(
q{ insert into system(system,galaxy,government,economy,techlevel,
                    name,description,inhabitants,
                    radius,population,productivity,xcoord,ycoord)
   values( ?,?,?,?,?,
            ?,?,?,
            ?,?,?,?,?
    )
   }
);
my $j_parse = new JSON;
$j_parse->utf8(1);

my $match = qr/\[\[Script "eight extractor" version [^\]]+\]\]: (.+)/;

while ( my $line = <STDIN> ) {
    chomp $line;
    my ($payload) = $line =~ $match;
    next unless $payload;
    my $galaxy = $j_parse->decode( $payload );
    my $galnum = $galaxy->{galaxy};
    while ( my ($sysnum,$sysinfo) = each %{$galaxy->{systems}} ) {
        warn Dumper $sysinfo;
        my @bindvars = (
                    $sysnum,$galnum, 
            @{$sysinfo}{qw(government economy techlevel
                        name description inhabitants
                        radius population productivity)},
            @{$sysinfo->{coordinates}} 
        );
        warn Dumper \@bindvars;
        $sys_insert->execute(@bindvars);

    }
#    print "Got galaxy " . Dumper $galaxy;
}
