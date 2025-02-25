%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%right POINTVIRGULE

%token TOK POINTVIRGULE

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
  | 'e' liste '\n' { printf("OK (liste)\n"); }
  | 'f' listf '\n' { printf("OK (listf)\n"); }
  | 'h' list_droit_rec '\n' { printf("OK (récursive droite)\n"); }
  | 'g' list_gauche_rec '\n' { printf("OK (récursive gauche)\n"); }
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

liste:
    /* Vide */
  | TOK
  | liste ',' TOK
  ;
  

listf :
      /* Liste vide */
      | TOK
      | TOK ',' listf
      ;


list_droit_rec:
    TOK POINTVIRGULE
  | TOK POINTVIRGULE list_droit_rec
  ;


list_gauche_rec:
    TOK POINTVIRGULE
  | list_gauche_rec TOK POINTVIRGULE
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

