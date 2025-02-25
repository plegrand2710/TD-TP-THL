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

    GA MEU
  | BU ZO

  | GA word MEU
  | BU word ZO
  
  | GA word word MEU
  | BU word word ZO
  
  | GA word word word MEU
  | BU word word word ZO
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

