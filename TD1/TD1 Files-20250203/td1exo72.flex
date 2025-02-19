%option nounput noinput
%{
#include <stdio.h>
#include <string.h>

int last_empty = 0;  // Variable pour suivre l'état de la dernière ligne vide

void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, GREEN("[\\n]")"\n");
}

%}

%%

[ \t\r\n]*  {        // Ligne vide ou contenant uniquement des espaces/tabulations
    if (!last_empty) {  // Si ce n'est pas déjà une ligne vide consécutive
        printf("\n");    // Affiche une seule ligne vide
        last_empty = 1;  // Marque que nous avons rencontré une ligne vide
    }
}

[^ \t\r\n][^\n]* {  // Ligne non vide
    last_empty = 0;  // Marque que nous avons rencontré une ligne non vide
    // Supprimer les espaces en fin de ligne
    char *line_end = yytext + strlen(yytext) - 1;
    while (line_end >= yytext && (*line_end == ' ' || *line_end == '\t' || *line_end == '\r')) {
        line_end--;  // Enlève les blancs en fin de ligne
    }
    *(line_end + 1) = '\0';  // Terminaison de la chaîne après suppression des blancs
    printf("%s", yytext);    // Affiche la ligne après avoir supprimé les blancs
    echonl();                // Affiche la fin de ligne
}

[ \t\r\n]+ {  // Remplacer les espaces consécutifs par un seul espace
    printf(" ");  // Remplacer les espaces et tabulations par un seul espace
}

\n {  // Gérer les retours à la ligne
    echonl();  // Affiche la fin de ligne
}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    while (yylex() != 0);
    return 0;
}

