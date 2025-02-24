%option nounput noinput
%{
#include "yyparse.h"
#include <stdio.h>

void yyerror(const char *s);
%}

%%

[ \t]+            { /* Ignorer les espaces et tabulations */ }
\"[^\"]+\"        { return STRING; }   // Chaîne entre doubles quotes
[A-Z][a-z]*       { return WORD_MAJ; } // Mot commençant par une majuscule
[a-z]+            { return WORD; }     // Mot en minuscule
\n                { return '\n'; }
[.]               { return '.'; }
.                 { printf("Caractère non reconnu: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

