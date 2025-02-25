%{
extern int yylex(); 

#include <stdio.h>
#include "symtab.h"
#include <math.h> /* function pow(), necessite gcc .... -lm */
#include "proto-color.h"
int yyerror (char const *message) { 
  fprintf(stderr,RED("<%s>")"\n", message);
  return 0;
}

void print(char *msg) {
    //    fprintf(stderr,BLUE("%s"),msg);
}

/*
struct {
float val;
int   init;
} Table_Symb[26];
*/

%}

%error-verbose

%union {
  int entier;
  float flottant;
  int index;
  symbol symbol;
}

%type	<flottant> Expr Min_Args
%token  F_MIN F_MAX
%token	<flottant> FLOTTANT
%token	<entier> ENTIER
%token	<symbol> VAR

%token	'(' ')' '\n'

%right  '='
%left   '+' '-' 
%left   '*' '/' '%' 
%left UMINUS
%left '^'

%% 
ExprList :  //Mot vide
         |  ExprList '\n' // Ligne vide
         |  ExprList Expr '\n'  
                {printf(" == %f\n", $2);}
         |  ExprList error '\n'
		{yyerrok; printf(RED(" Ligne invalid\n"));}

	 ;
Expr    : FLOTTANT   {$$=$1;}
	| ENTIER     {$$=(float)$1;}
	| VAR        {
                     $$=$1->double_data;
                     if ($1->data_type==0)
			  printf(RED("Warning : Variable %s not initialised"),$1->symb);
                     }
        |  VAR '=' Expr 
                  { 
                     $1->double_data=$3;
                     if ($1->data_type == 1)
		       printf(RED("Warning : Variable (%s) reaffectation"),$1->symb);
                     $1->data_type = 1;
		     printf(" %s <- %f\n", $1->symb, $3);
                     $$=$3;
                  }
	| '(' Expr ')'
                { print("()"); $$=$2; }	
	|  Expr '+' Expr 
                { print("+"); $$=$1+$3; }	
	|  Expr '-' Expr 
                { print("-"); $$=$1-$3; }	
	|  Expr '*' Expr 
                { print("*"); $$=$1*$3; }	
	|  Expr '/' Expr 
                { print("/"); $$=$1/$3; }	
	|  Expr '^' Expr 
	        { print("^"); $$=pow($1,$3); }	
	| ENTIER  '%' ENTIER
                { print("%"); $$=$1%$3; }
	|  '-' Expr 
                { printf(BLUE("UMOINS(%f)"),$2); $$=-$2; }	
	|  F_MAX '(' Expr ',' Expr ')' 
	        { print("max"); if ($3<$5) $$=$5; else $$=$3; }	
	|  F_MIN '(' Min_Args ')' 
	        { print("min"); $$=$3; }	
;
Min_Args : Expr        {$$=$1;}
	| Min_Args ',' Expr
	      {if ($3>$1) $$=$1; else $$=$3;}
;
%%
int main(void) { return yyparse(); }
