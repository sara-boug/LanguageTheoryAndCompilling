%%
%class  LexicalAnalyzer
%unicode 
%line
%column
 

%standalone 
// 1 : detecting end of lines and adding \n on each
%xstate YYINITIAL , LINEEND , ANALYSIS

%{
   StringBuffer string = new StringBuffer(); 
%}
// the end of the program 
%eofval{ 
      
%eofval}
Line  = .+
ENDOFLINE  = "\n"|"\r" |"\n\r"
 
%%
// initial state 
<YYINITIAL> { 
{Line} {     Symbol s =  new Symbol(LexicalUnit.ENDLINE ,  yyline , string.length(), "/n" ); 
             System.out.println( s.toString()); }



 


}


//adding \n to each end of line 
  
/*
[^("\n"|"\r" |"\n\r")]  + { 
             string.append(yytext());
             string.append("\n");  
             System.out.println( string);
 

          
             }*/




