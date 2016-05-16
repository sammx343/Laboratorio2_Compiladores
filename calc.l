%{
#include "y.tab.h"
#include "y.tab.h"
extern int yylineno;
%}


%option yylineno
DIGITO   [0-9]
LETRA    [a-zA-Z]
REAL     {DIGITO}+(.{DIGITO}+)?(e(\+|-)?{DIGITO}+)?
%%

"#include"	       	   {return INCLUDE;}
"if"                   {return SI;}
"else"                 {return SINO;}
"else if"              {return SINO_SI;}
"for"                  {return PARA;}
"while"                {return MIENTRAS_QUE;}
"do"                   {return HAGA_HASTA;}
"switch"               {return DEPENDIENDO_DE;}
"case"			       {return CASO;}
"break"			       {return BREAK;}
"default"			   {return DEFAULT;}

"scanf"                {return LEER;}
"printf"               {return ESCRIBIR;}

"=="                   {return IGUAL_IGUAL;}
"<="                   {return MENOR_IGUAL;}
">="                   {return MAYOR_IGUAL;}
"<"					   {return MENOR;}
">"					   {return MAYOR;}	
"="                    {return IGUAL;}
"!="                   {return DIFERENTE;}

"-"					   {return MENOS;}
"+"					   {return MAS;}
"*"                    {return MULTIPLICACION;}
"/"                    {return DIVISION;}
"^"                    {return EXP;}

"&&"                   {return OP_Y;}
"||"                   {return OP_O;}
"~"                    {return OP_NO;}

"void"                 {return VOID;}
"main"                 {return MAIN;}
"("                    {return PARENT_A;}
")"                    {return PARENT_C;}
"{"                    {return INICIO;}
"}"                    {return FIN;}

","                    {return COMA;}
";"                    {return PUNTOYCOMA;}
"."					   {return PUNTO;}
":"					   {return DOS_PUNTOS;}

"\+\+|--"			   {return MM;}

"int"                  {return TIPO_INT;}
"float"                {return TIPO_FLOAT;}
"char"                 {return TIPO_CHAR;}
"print"				   {return print;}

{LETRA}({LETRA}|{DIGITO})* 		{return ID;}

(-)?[0-9]+                 		{return NUMERO;}
(-)?[0-9]+.[0-9]+		   		{return DECIMAL;}
\"(\\.|[^"])*\"        		    {return CTE_CADENA;}
[ \t\n]                ;
%%
int yywrap (void) {return 1;}