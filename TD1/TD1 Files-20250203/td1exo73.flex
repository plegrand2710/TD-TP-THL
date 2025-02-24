%option nounput noinput
%{
#include <stdio.h>

int line_count = 0;
int word_count = 0;
int char_count = 0;

%}

%%


\n           { line_count++; char_count++; }


[^\t\n\f\v\r ]+ { word_count++; char_count += yyleng; }


[ \t\f\v\r]   { char_count += yyleng; }


.             { char_count += yyleng; }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    printf("Lignes : %d\n", line_count);
    printf("Mots   : %d\n", word_count);
    printf("Caractères : %d\n", char_count);
    return 0;
}
