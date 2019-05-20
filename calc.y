%{
#include <stdio.h>
#include <ctype.h>
%}

%token NUMBER

%%

command: exp {printf("%d\n",$1);}
       ; /* permite la impresi\'on del resultado */

exp: exp '+' term {$$ = $1 + $3;}
   | exp '-' term {$$ = $1 - $3;}
   | term {$$ = $1;}
   ;

term: term '*' factor {$$ = $1 * $3;}
    | factor {$$ = $1;}
    ;

factor: NUMBER {$$=$1;}
      | '('exp')' {$$=$2;}
      ;
%%

main()
{
extern int yydebug;
yydebug=1;
return yyparse();
}

int yylex(void)
{
int c;


while ((c=getchar())== ' ');
// elimina blancos 
if (isdigit(c)){
	ungetc(c,stdin);
	scanf("%d",&yylval);
	return NUMBER;
}
if(c=='\n') return 0;
// hace que se detenga el análisis sintáctico 
return(c);
}


int yyerror(char * s)
{
fprintf(stderr, "%s\n",s);
} /* permite la impresión de un mensaje de error */
