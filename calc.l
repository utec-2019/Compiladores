number [0-9]+.?|[0-9]*.[0-9]+

%%
[ ] { /* skip blanks */ }
{number} { return NUMBER;
	}

\n|. {return yytext[0];} 
