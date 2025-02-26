%{
#include <stdio.h>
#include <stdlib.h>

#define YYINITDEPTH 10000
#define YYMAXDEPTH 20000

void yyerror(const char *s);
int yylex(void);
%}

%token GA BU ZO MEU

%%

input:

  | input word '\n' { printf("Mot MeuMeu valide\n"); }
  | error '\n' { printf("Mot non MeuMeu\n"); yyerrok; }
  ;

word:

  | word GA word MEU
  | word BU word ZO
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

