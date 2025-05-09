%option nounput noinput
%{
#include "proto-color.h"
void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}
void echo1(char *lex_cat) {
    fprintf(stdout, REV(GREEN("[%s:%s]")), lex_cat, yytext);
}
void echo2(char *lex_cat) {
    fprintf(stdout, RED("[%s:%s]"), lex_cat, yytext);
}
int nbOK = 0, nbNOT = 0;
%}

OK    a[ab]*|[ab]*a
NOT   b[ab]*b
%%

^{OK}$   echo("OK"); nbOK++;
^{NOT}$  echo1("NOT"); nbNOT++;
\n       ECHO;
^[ab]*$   echo2("UNK");
.*        echo2("UNK");

%%

int yywrap(void) {
    printf("Nb_OK = %d, Nb_NOT = %d\n", nbOK, nbNOT);
    return 1;
}

int main(int argc, char *argv[]) {
    while (yylex() != 0);
    return 0;
}

