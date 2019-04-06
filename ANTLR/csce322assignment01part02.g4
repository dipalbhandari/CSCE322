grammar csce322assignment01part02;
@members{
	int players = 0;
	int rows = 1;
	int cols = 0;
	int maxCol = 0;
	int pieces = 0;

	int flag = 0;
    
}

// rules
connectFour :  (moves game rules EOF) | (game moves rules EOF);
game : title sectionBeginning gameBeginning gameRow gameRow gameRow+ gameCol gameCol gameCol gameCol+ gameEnding sectionEnding;
moves : title sectionBeginning listBeginning placeholder+ moveNum listEnding sectionEnding;
placeholder : moveNum MS;
gameRow : (gameCol gameCol gameCol gameCol+ rowEnding);
gameCol : (gameNum | gameSymbol) {cols++;};


title : TT;
sectionBeginning : SB;
listBeginning : MB;
listEnding : ME;
sectionEnding : SE;
gameBeginning : GB;
gameSymbol : GS;

gameNum: NS {
	pieces++;
	if(Integer.parseInt($NS.text) > players){
		players = Integer.parseInt($NS.text);
	}

};


moveNum: NS{
	if(Integer.parseInt($NS.text) > maxCol){
		maxCol = Integer.parseInt($NS.text);
	}
};
gameEnding : GE;
rowEnding : RE{rows++;cols = 0;};

rules:{
	
	if(players<2){
	System.out.println("SEMANTIC PROBLEM 1");
	flag = 1;

	}

	if(rows<6 || rows >10){
	System.out.println("SEMANTIC PROBLEM 2");
	flag = 1;

	}

	if(cols<6 || cols >10){
	System.out.println("SEMANTIC PROBLEM 3");
	flag = 1;

	}

	if(maxCol > cols) {

	System.out.println("SEMANTIC PROBLEM 4");
	flag = 1;

}

	if(flag == 0){
	System.out.println(pieces + " pieces have been played");
	}

};




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

