%option nounput noinput
%{
#include "yyparse.h"
#include <stdio.h>

void yyerror(const char *s);
int nb_errors = 0;
%}

%%

[ \t]+              { /* Ignorer les espaces et tabulations */ }
\"[^\"]+\"          { return STRING; }
[A-Z][a-z]*         { return WORD_MAJ; }
[a-z]+              { return WORD; }
,                   { return ','; }
\n                  { return '\n'; }
[.]                 { return '.'; }

.                   { 
                      fprintf(stderr, "Erreur lexicale : caractère non reconnu '%s'\n", yytext);
                      nb_errors++;
                    }

%%

int yywrap() {
    return 1;
}

