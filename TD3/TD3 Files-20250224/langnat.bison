%{
extern int yylex();

#include <stdio.h>
#include <stdlib.h>

#include "proto-color.h"
int yyerror (char const *message) { 
  fprintf(stderr,RED("<%s>")"\n", message);
  return 0;
}

%}
%token	ART NOM VERBE ADJ '.' '\n'
%%
Texte	:
	|	Texte  Phrase '.' '\n'
		{ printf("\n" ); }
	;
Phrase	:	GpeNom  VERBE  GpeNom
		{ printf("<Phrase> " ); }
	;
GpeNom	:	ART  NOM  ADJ
		{ printf("<GpeNom> "); }
	;
%%
int main(void) { return yyparse(); }
