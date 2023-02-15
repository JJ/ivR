#!/usr/bin/env perl6

use Digest::MD5;

my @lines = "../IV-21-22/data/fechas-entrega.csv".IO.lines;

say @lines.shift;

for @lines -> $l {
    my ($objetivo,$name, @rest ) = $l.split(";");
    my $md5 = md5($name).map( *.base(16)).join("");
    say [ $objetivo, $md5, |@rest ].join(";");
}
