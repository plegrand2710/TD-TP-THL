%option nounput noinput

%{
#include <stdio.h>
#include <string.h>

int current_length = 0;
%}

%%


[ \t]+  { printf(" "); current_length++; }


^[ \t]*\n  { printf("\n"); current_length = 0; }


(.{1,80}[ \t]+)  { printf("%s\n", yytext); current_length = 0; }


[^\t\n ]+  { printf("%s", yytext); current_length += yyleng; }


\n  { }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    return 0;
}

