%{
/* lexical.lex */

#include "tpc-2020-2021.tab.h"

int line_count = 1;
int word_count = 0;
int word_count2 = 0;
char line[100];

%}

%x COM

%option noyywrap
%option nounput
%option noinput

%%

"/*" BEGIN COM;

<COM>"*/" BEGIN INITIAL;
<COM>"\n" { line_count++; }
<COM>. ;

struct                 { word_count2=word_count; word_count+=6; return STRUCT;}
int                    { word_count2=word_count; word_count+=3; return TYPE; }
char                   { word_count2=word_count; word_count+=4; return TYPE; }
float                  { word_count2=word_count; word_count+=5; return TYPE; }
void                   { word_count2=word_count; word_count+=4; return VOID; }
if                     { word_count2=word_count; word_count+=2; return IF; }
else                   { word_count2=word_count; word_count+=4; return ELSE; }
while                  { word_count2=word_count; word_count+=5; return WHILE; }
print                  { word_count2=word_count; word_count+=5; return PRINT; }
\|\|                   { word_count2=word_count; word_count+=2; return OR; }
&&                     { word_count2=word_count; word_count+=2; return AND; }
"=="                   { word_count2=word_count; word_count+=2; return EQ; }
"!="                   { word_count2=word_count; word_count+=2; return EQ; }
"<"|">"                { word_count2=word_count; word_count++; return ORDER; }
"<="|">="              { word_count2=word_count; word_count+=2; return ORDER; }
"return"               { word_count2=word_count; word_count+=6; return RETURN; }
[/*%]                  { word_count2=word_count; word_count++; return DIVSTAR; }
[+-]                   { word_count2=word_count; word_count++; return ADDSUB; }
'.'                    { word_count2=word_count; word_count++; return CHARACTER; }
[0-9]+                 { word_count2=word_count; word_count++; return NUM; }
reade                  { word_count2=word_count; word_count+=5; return READE; }
readc                  { word_count2=word_count; word_count+=5; return READC; }
[a-zA-Z_][a-zA-Z_0-9]* { word_count2=word_count; word_count+=strlen(yytext); return IDENT; }
"\n"                   { line_count++; word_count2=word_count; word_count = 0; }
[\t]                   { word_count2=word_count; word_count+=4; }
[ ]                    { word_count2=word_count; word_count++; }
.                      { word_count2=word_count; word_count++; return yytext[0]; }

"\n".*"\n" { strcpy(line, yytext); REJECT; }

%%
