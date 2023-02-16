ALL: data/all-data.rda

data/entregas-21-22.rda: data-raw/fechas-entrega-2021-22.csv script/convert-from-raw.R
	script/convert-from-raw.R

data/entregas-22-23.rda: data-raw/fechas-entrega-2022-23.csv script/convert-from-raw.R
	script/convert-from-raw.R data-raw/fechas-entrega-2022-23.csv "2022-09-13T00:00:00+02:00" 22-23

data/all-data.rda: data/entregas*.rda script/convert-from-raw.R
	script/merge-data.R
