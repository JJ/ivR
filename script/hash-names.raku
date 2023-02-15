#!/usr/bin/env perl6

use Digest::MD5;

my $file = @*ARGS[0] // "../IV-21-22/data/fechas-entrega.csv";

my @lines = $file.IO.lines;

say @lines.shift;

for @lines -> $l {
    my ($objetivo,$name, @rest ) = $l.split(";");
    my $md5 = md5($name).map( *.base(16)).join("");
    say [ $objetivo, $md5, |@rest ].join(";");
}
