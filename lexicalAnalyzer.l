
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "syntaxAnalyzer.tab.h"
%}

%%

"fmt.println"					return PRINT;
"for"							return FORSTMT;
"var"							return VAR;
[a-zA-Z]([a-zA-Z0-9])*			{yylval.id = strdup(yytext); return IDENTIFIER;}
\;								return SEMICOLON;
[0-9]+                		  	{yylval.num = atoi(yytext);return NUMBER;}
[\-\+\=\;\*\/\(\)\:\{\}]    	{return yytext[0];}
%%

int yywrap(void){ 
return 1;
}
