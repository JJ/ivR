#!/usr/bin/env raku

use Text::CSV;

my $file = @*ARGS[0] // "data-raw/evaluacion-resultados-21-22.csv";

my @resultados = $file.IO.lines;

my @procesados;
for @resultados[1..*] -> $fila {
    my @fila = $fila.split(/\t/);
    my %fila =  %(aprobado  => @fila[1] >= 4 );
    my @circunstancias = @fila[3].split(",");
    for @circunstancias -> $c {
        %fila{$c} = 1;
    }
    @procesados.push: %fila;
}

my $file-name = $file.split("/")[1];
csv( in => @procesados, out => "data-raw/circunstancias-{$file-name}", )