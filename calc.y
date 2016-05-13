%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}

%union {int num; char id;}         /* Yacc definitions */
%start struct
%token print
%token <id> VOID PARENT_A PARENT_C INICIO FIN TIPO_INT TIPO_FLOAT TIPO_CHAR MAIN COMA PUNTOYCOMA DOS_PUNTOS INCLUDE SI SINO SINO_SI PARA MIENTRAS_QUE HAGA_HASTA DEPENDIENDO_DE CASO BREAK DEFAULT MM NUMERO ID CTE_CADENA IGUAL IGUAL_IGUAL MENOR_IGUAL MAYOR_IGUAL MAYOR MENOR DIFERENTE DECIMAL MENOS MAS MULTIPLICACION DIVISION EXP OP_Y OP_O OP_NO PUNTO LEER ESCRIBIR 

%type <id> assignment declaracion tipo term exp comparison 
%type <id> line body
%type <id> struct
%type <id> header
%type <id> for if elseif while do_while switch cases
%type <id> op_comp op_logico op_mat operacion 
%type <id> numerico
%type <id> op_corta op_larga
%type <id> scanf printf
%%

/* descriptions of expected inputs     corresponding actions (in C) */

/* Gramatica inicial void main(){} */





/* /////////////////////////////////////////////// ESTRUCTURA GENERAL */




struct  : VOID MAIN PARENT_A PARENT_C INICIO body FIN
		| header struct
		;

/* Cabecera #include <> */

header	: INCLUDE MENOR ID PUNTO ID MAYOR
		| INCLUDE MENOR ID MAYOR
		;

/* Cuerpo del algoritmo */

body	: line
		| line body 
		|
		;

/*Lineas individuales del algoritmo 
  que contienen asignaciones, operaciones
  primitivas, etc.
*/

line    : assignment PUNTOYCOMA
		| operacion PUNTOYCOMA
		| scanf PUNTOYCOMA
		| printf PUNTOYCOMA
		| for
		| if
		| while
		| do_while
		| switch
        ;




/* ////////////////////////////////////////////// ESTRUCTURA DE LINEAS */




/* Comparacion de terminos 
   ej: a == b  || cadena != numero 
*/

comparison : term op_comp term
		   | comparison op_logico comparison
		   | op_larga op_comp op_larga
		   | op_larga op_comp term
		   | term op_comp op_larga
		   ; 

/* Asignacion de variables con respectivo tipo
   ej:  int k = 4;
   		char cadena = "";
   		b = 4; b = a;
*/

assignment : tipo ID IGUAL exp
		   | ID IGUAL exp
		   | tipo declaracion 
		   ;

/* Declaracion de variable */

declaracion : ID COMA declaracion
			| ID
			;




/* ///////////////////////////////// PRIMITIVAS CONDICINALES Y LECTURA/ESCRITURA */



/* Leer variables */

scanf	: LEER PARENT_A CTE_CADENA COMA declaracion PARENT_C

/* Escribir variables */

printf	: ESCRIBIR PARENT_A CTE_CADENA COMA declaracion PARENT_C

/* Ciclo para */

for		: PARA PARENT_A assignment PUNTOYCOMA comparison PUNTOYCOMA operacion PARENT_C INICIO body FIN 
		;

/* Ciclo while */

while	: MIENTRAS_QUE PARENT_A comparison PARENT_C INICIO body FIN
		;

/* Ciclo do while */

do_while   :  HAGA_HASTA INICIO body FIN MIENTRAS_QUE PARENT_A comparison PARENT_C

/* Condicional if */

if		:  SI PARENT_A comparison PARENT_C INICIO body FIN
		|  SI PARENT_A comparison PARENT_C INICIO body FIN SINO INICIO body FIN
		|  SI PARENT_A comparison PARENT_C INICIO body FIN elseif
		|  SI PARENT_A comparison PARENT_C INICIO body FIN 	elseif SINO INICIO body FIN
		;  
elseif  : SINO_SI PARENT_A comparison PARENT_C INICIO body FIN elseif
		| SINO_SI PARENT_A comparison PARENT_C INICIO body FIN
		;

switch  : DEPENDIENDO_DE PARENT_A term PARENT_C INICIO cases FIN
		;

cases	: CASO term DOS_PUNTOS body BREAK PUNTOYCOMA cases 
		| CASO term DOS_PUNTOS body BREAK PUNTOYCOMA
		| DEFAULT DOS_PUNTOS body 




/* //////////////////////////////////// ESTRUCTURA DE VARIABLES Y DECLARACIONES*/





/* Suma de terminos individuales
*/

exp    	: term                  
       	| exp MAS term          
       	| exp MENOS term         
       	;

/* Definicion del tipo: int, float, char */

tipo    : TIPO_INT
		| TIPO_FLOAT
		| TIPO_CHAR
		; 

/* Cualquier termino: "cadena", 4,5,411, variable*/

term   	: numerico       
		| CTE_CADENA
		| ID
        ;

/* Solo numeros o variables: -5, 5.412, num */

numerico : NUMERO
		 | DECIMAL
		 | ID
		 ;




/* ////////////////////////////// OPERADORES DE COMPARACION, MATEMATICOS, ETC */




/* Operadores de comparacion: < , <= , !=, == */

op_comp  : MAYOR
		 | MENOR
		 | IGUAL_IGUAL
		 | MENOR_IGUAL
		 | MAYOR_IGUAL 
		 | DIFERENTE
		 ;

/* Operadores lógicos: && , || */

op_logico : OP_Y
		  | OP_O 
		  | OP_NO
		  ;

/* Operadores matematicos: +,-,*, / */

op_mat	 :  MAS
		 |  MENOS
		 |  MULTIPLICACION
		 |  DIVISION
		 ;

/* Operaciones entre variables o numeros */

operacion : op_corta
		  | ID IGUAL op_larga
		  ;

/* Operaciones abreviadas del tipo i++; j*=4; */

op_corta  : ID op_mat IGUAL numerico
		  | ID MAS MAS
		  | ID MENOS MENOS
		  ;

/* Operaciones matematicas largas del tipo i=4+5+j; j=j+1 */

op_larga  : numerico op_mat numerico
		  | numerico op_mat op_larga
		  ;
%%          





/* C code */




int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

/*
exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;} */