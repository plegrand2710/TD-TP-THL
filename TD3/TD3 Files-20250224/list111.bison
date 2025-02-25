%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);  
int yylex(void);
%}

%token TOK '\n'

%%
Line : /*vide*/
     | Line list '\n'  {printf("Ligne OK\n");}
     | Line error '\n' {yyerrok; printf("Ligne Fausse\n");}
;
list : TOK
%%

void yyerror(const char *s) {
    // Message d'erreur (non utilisé directement car géré dans les règles)
}

int main(void) {
    yyparse();
    return 0;
}

