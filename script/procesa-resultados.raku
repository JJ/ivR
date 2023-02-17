#!/usr/bin/env raku

use Text::CSV;

my $file = @*ARGS[0] // "evaluacion-resultados-21-22.csv";

my @resultados = csv(in => $file,
        headers => "auto",
              sep => "\t");
print @resultados;