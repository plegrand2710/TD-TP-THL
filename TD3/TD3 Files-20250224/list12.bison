%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token TOK

%%

input:
    /* Vide */
  | input line
  ;

line:
    'a' lista '\n' { printf("OK (lista)\n"); }
  | 'b' listb '\n' { printf("OK (listb)\n"); }
  | 'c' listc '\n' { printf("OK (listc)\n"); }
  | 'd' listd '\n' { printf("OK (listd)\n"); }
  | error '\n' { printf("FAUX\n"); yyerrok; }
  ;

lista:
    TOK
  | lista TOK
  ;

listb:
    TOK
  | TOK listb
  ;

listc:
    TOK
  | listc listc
  ;

listd:
    /* Vide */
  | listd TOK
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

