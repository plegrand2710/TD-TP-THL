%option nounput noinput

%{
#include "proto-color.h"
#include <stdio.h>

void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s:%s]"), lex_cat, yytext);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}
%}

%%
"for"|"while"|"if"|"else"|"return"|"int"|"float"|"double"|"char" { echo("KW"); }

"+"|"-"|"*"|"/"|"<"|">" { echo("OP"); }

"(" | ")" | "{" | "}" | ";" | "," | "[" | "]" { echo("SEP"); }

[0-9]+\.[0-9]+ | [0-9]+ { echo("NUM"); } 

[a-zA-Z_][a-zA-Z0-9_]* { echo("SYMB"); } 

[\n\r]+ { echonl(); }  

[ \t]+ {}

. { echo("Unknown"); }

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
