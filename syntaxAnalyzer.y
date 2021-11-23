
%{

char* temp[200];
int tempVal[200];

void yyerror(char *s);
extern int yylex();
extern int yyparse();
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


void setval(char* n,int a);
void update (char* n,int a);
int getval (char* n);
%}

%union{ int num; char* id;}
%start	START
%token  FORSTMT
%token	PRINT
%token	VAR
%token  <id> IDENTIFIER
%token	SEMICOLON
%token	<num>	NUMBER
%type	<num>	START EXP  TERM
%type   <id> 	ASSIGNMENT

%%

START    : PRINT '(' EXP ')' SEMICOLON       				{printf("%d\n",$3);}
        | START PRINT '(' EXP ')' SEMICOLON   				{printf("%d\n",$4);}  
		| FORSTMT  EXP ':' EXP  '{' PRINT '(' EXP ')' SEMICOLON  '}'   	{int i;for(i = $2 ; i < $4 ; i++) { printf("%d\n",$8); }}
		| START FORSTMT  EXP ':' EXP  '{' PRINT '(' EXP ')' SEMICOLON  '}'   	{int i;for(i = $3 ; i < $5 ; i++) { printf("%d\n",$9); }}
        |VAR ASSIGNMENT  SEMICOLON   {;}
		|START VAR ASSIGNMENT SEMICOLON {;}
		; 
		
		
EXP     	:  TERM             {$$ = $1;}
	    |  EXP '+' TERM        	{$$ = $1 + $3;}
        |  EXP '-' TERM        	{$$ = $1 - $3;}
        |  EXP '*' TERM         {$$ = $1 * $3;}
        |  EXP '/' TERM       	{$$ = $1 / $3;}
        ;
		
TERM   : NUMBER      				{$$ = $1;}
		|IDENTIFIER                  {$$=getval($1);}
		;
		
		
ASSIGNMENT : IDENTIFIER '=' EXP     {update($1,$3);}
		
%%

void setval(char* n,int a){
int i;
int flag=0;
for(i=0;i<200;i++){
if(strcmp(temp[i],"")==0){
temp[i]=n;
tempVal[i]=a;
flag=1;
break;
}

}
if(flag==0){
printf("No more room for storing the identifier\n");

}
}


void update(char* n,int a){
int i;
int flag=0;
for(i=0;i<200;i++){
if(strcmp(temp[i],n)==0){
tempVal[i]=a;
flag=1;
break;
}

}
if(flag==0){
setval(n,a);

}
printf("the variable is declared seccussfully");
}

int getval (char* n){
int i;
int flag=0;
for(i=0;i<200;i++){
if(strcmp(temp[i],n)==0){
return tempVal[i];
flag=1;
}

}
if(flag==0){
printf("the identifieris not found!\n");

}

}





int main (void)
{
int i; 
for(i=0;i<200;i++){
temp[i]="";
tempVal[i]=0;
}


    return yyparse();
}

void yyerror (char *s)
{
    printf("-%s at %s !\n",s );
}
