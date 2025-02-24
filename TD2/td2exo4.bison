%{
#include <stdio.h>
#include "proto-color.h"

void yyerror(const char *s);
int yylex();
extern int nb_errors;  // Partagé avec Flex
%}

%token ART TRANS_VRB COMM_NOUN PROP_NOUN
%token '.' '\n'
%error-verbose

%%

Text:
      /* Vide */
    | Text Ligne
    ;

Ligne:
      '\n'  { printf(GREEN "Ligne vide détectée\n" RESET); }
    | Phrase '.' '\n'  { printf(GREEN "Phrase correcte détectée\n" RESET); }
    | error '\n'  {
                      fprintf(stderr, RED "Erreur détectée dans la ligne. Passage à la suivante.\n" RESET);
                      yyerrok; // Réinitialise l'état d'erreur
                  }
    ;

Phrase:
      GroupeNom TRANS_VRB GroupeNom
    ;

GroupeNom:
      PROP_NOUN  { printf(BLUE "Nom propre détecté\n" RESET); }
    | ART COMM_NOUN  { printf(BLUE "GroupeNom détecté (Article + Nom Commun)\n" RESET); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, RED "Erreur syntaxique : %s\n" RESET, s);
    nb_errors++;
}

int main(void) {
    int result = yyparse();
    if (nb_errors > 0) {
        fprintf(stderr, RED "\nAnalyse terminée avec %d erreur(s) détectée(s).\n" RESET, nb_errors);
    } else {
        printf(GREEN "\nAnalyse réussie sans erreur.\n" RESET);
    }
    return result;
}

