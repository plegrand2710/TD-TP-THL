%option nounput noinput

%{
#ifdef FLEXALONE 
  enum Return_Token_Values { TOK=1000};
#else            
  #include "yyparse.h"  
#endif
%}

%% 
[0-9]*		sscanf(yytext,"%d", &yylval);return(TOK);
[ \t]           ;
.|\n		return(yytext[0]);
%%

int yywrap (void) {return 1;}
#ifdef FLEXALONE 
  int main(int argc, char *argv[]) { while (yylex()!=0) ; return 0; } 
#endif
