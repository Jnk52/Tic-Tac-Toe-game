#!/bin/bash

echo "Welcome to the Tic Tac Toe game"
#declaring the array for board positions
sheet=(1 2 3 4 5 6 7 8 9)
number=0;
player=1;
computer=0;
#declaring the function for resetting the board
setTheBoard() {
        for position in {1..9}
        do
                sheet[((number++))]=$position
        done
        echo "${sheet[0]} | ${sheet[1]} | ${sheet[2]}"
        echo "${sheet[3]} | ${sheet[4]} | ${sheet[5]}"
        echo "${sheet[6]} | ${sheet[7]} | ${sheet[8]}"
}
setTheBoard


#TOSS BEFORE THE GAME

#lets take a function for toss
toss(){
        #lets decalre raandom variable for toss
        tossDecision=$((RANDOM%2))

        #check who wins the toss
        if [ $tossDecision -eq $player ]
        then
                echo "player won the toss and he is gonna start the game"
        else
                echo "computer won the toss and gonna start the game"
        fi
        }
toss

#DECLARATION OF LETTERS

#lets take function for declaring letters
letterSymbols(){
if [ $tossDecision -eq $player ]
        then
                read -p "SELECT LETTER SYMBOL x OR o TO PLAY THE GAME: " playerSymbol
                if [ "$playerSymbol" == "o" ]
                then
                        computerSymbol="x"
                else
                        computerSymbol="o"
                fi
        else
                #COMPUTER TURN RANDOMLY CHOOSES x OR o

                computerSymbolToss=$((RANDOM%2))
                if [ $computerSymbolToss -eq 1 ]
                then
                        computerSymbol="o"
                        playerSymbol="x"
                else
                        computerSymbol="x"
                        playerSymbol="o"
                fi
        fi
                }
letterSymbols

echo "computer symbol = $computerSymbol"
echo "player symbol = $playerSymbol"

