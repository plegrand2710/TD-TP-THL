%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token TOK '\n'
%%
Line : /* vide */
     | Line list '\n'  {printf("Ligne OK\n");}
     | Line 'a' lista '\n'  {printf("lista OK\n");}
     | Line 'b' listb '\n'  {printf("listb OK\n");}
     | Line error '\n' {yyerrok; printf("Ligne Fausse\n");}
;
list : TOK
lista : TOK
listb : TOK TOK
%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

