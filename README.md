# Laboratorio2_Compiladores

lex LAB01_castro_mayor_taborda.l

yacc -d LAB01_castro_mayor_taborda.y

gcc lex.yy.c y.tab.c -o LAB01_castro_mayor_taborda

On that order

./LAB01_castro_mayor_taborda               to write on console or

./LAB01_castro_mayor_taborda < calc.txt     to read the any C file
