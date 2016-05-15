# Laboratorio2_Compiladores

lex calc.l

yacc -d calc.y

gcc lex.yy.c y.tab.c -o calc

On that order

./calc                to write on console or
./calc < calc.txt     to read the any C file
