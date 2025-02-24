%option nounput noinput
%{
#include "yyparse.h"
#include <stdio.h>

void yyerror(const char *s);
int nb_errors = 0;  // Compteur d'erreurs
%}

%%

[ \t]+              { /* Ignorer les espaces et tabulations */ }
\"[^\"]+\"          { return STRING; }   // Chaîne entre guillemets
[A-Z][a-z]*         { return WORD_MAJ; } // Mot commençant par une majuscule
[a-z]+              { return WORD; }     // Mot en minuscule
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

