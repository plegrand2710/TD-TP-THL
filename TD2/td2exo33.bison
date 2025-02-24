%{
#include <stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token WORD WORD_MAJ STRING
%token '.' '\n'

%%

Text:
      /* Vide */
    | Text Sentence '\n'
    ;

Sentence:
      InitialMot Words '.'
      { printf("Phrase correcte détectée\n"); }
    ;

InitialMot:
      WORD_MAJ  { printf("Phrase commence par une majuscule\n"); }
    | STRING    { printf("Phrase commence par une chaîne\n"); }
    ;

Words:
      /* Vide */
    | Words WORD   { printf("Mot détecté\n"); }
    | Words STRING { printf("Chaîne détectée\n"); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur de syntaxe : %s\n", s);
}

int main(void) {
    return yyparse();
}

