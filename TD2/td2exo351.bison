%{
#include <stdio.h>
void yyerror(const char *s);
int yylex();
extern int nb_errors;
%}

%token WORD WORD_MAJ STRING
%token '.' ',' '\n'
%error-verbose

%%

Text:
      /* Vide */
    | Text Ligne
    ;

Ligne:
      '\n'  { printf("Ligne vide détectée\n"); }
    | Sentence '.' '\n'  { printf("Phrase correcte détectée\n"); }
    | error '\n'  { 
                      fprintf(stderr, "Erreur détectée dans la ligne. Passage à la suivante.\n");
                      yyerrok;
                  }
    ;

Sentence:
      InitialMot Words
    ;

InitialMot:
      WORD_MAJ  { printf("Phrase commence par une majuscule\n"); }
    | STRING    { printf("Phrase commence par une chaîne\n"); }
    ;

Words:
      /* Vide */
    | Words Mot
    ;

Mot:
      WORD  { printf("Mot détecté\n"); }
    | STRING { printf("Chaîne détectée\n"); }
    | ','  { printf("Virgule détectée\n"); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);
    nb_errors++;
}

int main(void) {
    int result = yyparse();
    if (nb_errors > 0) {
        fprintf(stderr, "\nAnalyse terminée avec %d erreur(s) détectée(s).\n", nb_errors);
    } else {
        printf("\nAnalyse réussie sans erreur.\n");
    }
    return result;
}

