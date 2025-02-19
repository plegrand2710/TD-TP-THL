%option nounput noinput

%{
#include <stdio.h>
#include "proto-color.h"

void echo(char *lex_cat) {
    fprintf(stdout, GREEN("[%s]"), lex_cat);
}

void echonl() {
    fprintf(stdout, RED("[\\n]")"\n");
}
%}

%%
/\*[^*]*\*+([^/*][^*]*\*+)*\// {echo("COM"); }

[ \t]+  { }
\n      { echonl(); }
.       { echo("TEXT"); }

%%

int yywrap(void) { return 1; }

int main(int argc, char *argv[]) { 
    while (yylex() != 0); 
    return 0; 
}
