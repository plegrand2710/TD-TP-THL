%option nounput noinput

%{
#include "yyparse.h"
#include "proto-color.h"
#include <stdio.h>

void yyerror(const char *s);
int nb_errors = 0;  // Compteur d'erreurs
%}

%%

[ \t]+              { /* Ignorer les espaces et tabulations */ }
"a"|"an"|"the"      { return ART; }
"cut"|"cuts"        { return TRANS_VRB; }
"bill"|"bills"      { return COMM_NOUN; }
"Bell"|"Verizon"    { return PROP_NOUN; }
\n                  { return '\n'; }
[.]                 { return '.'; }

.                   {
                      fprintf(stderr, RED "Erreur lexicale : caractère non reconnu '%s'\n" RESET, yytext);
                      nb_errors++;
                    }

%%

int yywrap() {
    return 1;
}

