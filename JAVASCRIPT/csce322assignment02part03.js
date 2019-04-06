module.exports = {
    manyPlayersOneMove: manyPlayersOneMove
}

var helpers = require( './helpers' );

function manyPlayersOneMove( game ){
    
    function whatever( move ){
    var maxPlayers = 0;
    for(var i = 0; i < game.length; i++){
        for(var j = 0; j < game[0].length; j++){
            if(game[i][j] != '-' && Number(game[i][j]) > maxPlayers){
                maxPlayers = Number(game[i][j]);
            }
        }
    }

    var flag = 0;
    var player = 1;
    while( flag  == 0 && player <= maxPlayers){
        for(var i = 0 ; i < move.length ; i++){
            var col = move[i] - 1; 
            for(var row = game.length-1 ; row >= 0;row--){
                if(game[row][col] == '-'){
                    game[row][col] = player.toString();
                    player++;
                    break;       
                }
            }
            if((horizontalWinner(game) ||  verticalWinner(game)  || diagonalWinner(game)) == true){

                flag = 1;
                break;
        }
        if(player > maxPlayers){
            flag = 1;
            break;
        }
        }
    }
    return game;
    }
return whatever;
}



//checking for the horizontal 
function horizontalWinner(game){

// row 
for(var i = 0 ; i < game.length ; i++){
   
   //colum take 1st row and iterate through each column
   for(var j = 0 ; j <game[0].length -3; j++){
      
      
    if(game[i][j] != '-' && game[i][j] == game[i][j+1] && game[i][j] == game[i][j+2] && game[i][j] == game[i][j+3]){

        return true 
    }
    
   }
}

return false;
}


// checking for vertical winner 

function verticalWinner(game){

    for(var i = 0 ; i < game.length-3; i++){

        for(var j = 0 ; j < game[0].length ; j++){

            if(game[i][j] != '-' && game[i][j] == game[i+1][j] && game[i][j] == game[i+2][j] && game [i][j] == game[i+3][j]){
                return true ; 
            }

            
        }
    }
    return false;
}



// checking for diagonal , left to right and right to left 
function diagonalWinner(game){

// for left to right 
    for(var i = 3 ; i < game.length ; i++){

        for(var j = 0 ; j < game[0].length -3; j++){

            if(game[i][j] != '-' && game[i][j] == game[i-1][j+1] && game[i][j] == game[i-2][j+2] && game[i][j] == game[i-3][j+3]){

                return true 
            }

        }


    }

for(var i = 3 ; i < game.length ; i++){

        for(var j = 3 ; j < game[0].length; j++){

            if(game[i][j] != '-' && game[i][j] == game[i-1][j-1] && game[i][j] == game[i-2][j-2] && game[i][j] == game[i-3][j-3]){

                return true 

        }


    }

}



return false;
}


