#!/usr/bin/env raku

use Text::CSV;

my $file = @*ARGS[0] // "data-raw/evaluacion-resultados-21-22.csv";

my @resultados = $file.IO.lines;

my @procesados;
for @resultados[1..*] -> $fila {
    my @fila = $fila.split(/\t/);
    my %fila =  %(
                    aprobado  => @fila[1] >= 4,
                    NoAsistencia => 0,
                    AsignaturasAtrasadas => 0,
                    Trabajando => 0,
                    ConocimientosPrevios => 0,
                    AsignaturasExigentes => 0,
                );
    given @fila[3] {
        when /"No puedo asistir"/ { %fila<NoAsistencia> = 1}
        when /"asignaturas atrasadas"/ { %fila<AsignaturasAtrasadas> = 1}
        when /"Estoy trabajando"/ { %fila<Trabajando> = 1}
    }

    given @fila[6] {
        when /"conocimientos previos"/ { %fila<ConocimientosPrevios> = 1}
        when /"trabajo excesiva"/ { %fila<AsignaturasExigentes> = 1}
    }
    @procesados.push: %fila;
}

my $file-name = $file.split("/")[1];
csv( in => @procesados, out => "data-raw/circunstancias-{$file-name}", )