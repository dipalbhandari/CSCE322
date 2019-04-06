grammar csce322assignment01part01;

// rules
connectFour :  (moves game EOF {System.out.println("End of File");} )  | (game moves EOF {System.out.println("End of File");})  ;
game : title sectionBeginning gameBeginning gameRow* (numericalSymbol | gameSymbol)+ gameEnding sectionEnding;
moves : title2 sectionBeginning listBeginning placeholder2* numericalSymbol listEnding sectionEnding;
placeholder2 : numericalSymbol MS;
gameRow : (numericalSymbol | gameSymbol)+ rowEnding ;


title : TT{System.out.println("Game Section");} | error;
title2 : TT{System.out.println("Moves Section");} | error;
sectionBeginning : SB{System.out.println("Beginning of Section");} | error;
listBeginning : MB{System.out.println("Beginning of List");} | error;
listEnding : ME{System.out.println("End of List");} | error;
sectionEnding : SE{System.out.println("End of Section");} | error;
gameBeginning : GB{System.out.println("Start of Game");} | error;
gameSymbol : GS{System.out.println("Space: Empty");} | error;
numericalSymbol : NS{System.out.println("Number: " + $NS.text);} | error;
gameEnding : GE{System.out.println("End of Game");} | error;
rowEnding : RE{System.out.println("End of Row");} | error;


error: ERROR {System.out.println("SYNTAX PROBLEM ON LINE " + $ERROR.line); System.exit(0);};

// tokens
TT: 'game ' | 'moves' ;
SB: '/*' ;
SE: '*/' ;
GS: ('-') ;
MS: ('_');
NS: [0-9]+ ;
RE: '|';
GB: '[';
GE: ']';
MB: '{';
ME: '}';
WS : [ \t\r\n]+ { skip();};

ERROR : .;
