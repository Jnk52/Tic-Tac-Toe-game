#!/bin/bash

flag=1
declare -a sheet
player=1
computer=0
count=0
#DECLARING THE ARRAY FOR BOARD POSITIONS

setTheBoard() {
        echo "${sheet[1]} | ${sheet[2]} | ${sheet[3]}"
        echo "${sheet[4]} | ${sheet[5]} | ${sheet[6]}"
        echo "${sheet[7]} | ${sheet[8]} | ${sheet[9]}"
}

#TOSS BEFORE THE GAME
#LETS TAKE A FUNCTION FOR A TOSS
toss() {
        #LETS DECLARE RANDOM VARIABLE FOR THE TOSS
        tossDecision=$((RANDOM%2))
        if [ $tossDecision -eq $player ]
        then
                echo "Player won the toss and he is gonna start the game"
        else
                echo "computer won the toss and gonna start the game"
        fi
}

#DECLARATION OF LETTERS
#LETS TAKE A FUNCTION FOR DECLARING LETTERS

letterSymbol() {
        if [[ $tossDecision -eq $player ]]
        then
                read -p "SELECT THE LETTER SYMBOL x OR o TO PLAY THE GAME: " playerSymbol
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

#LETS CREATE A  FUNCTION TO SEE WHO WINS
checkWinner() {
                symbol=$1
                winner=$2
                # CHECKING WITHE ROWS

                if [[ ${sheet[1]} == $symbol && ${sheet[2]} == $symbol && ${sheet[3]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                elif [[ ${sheet[4]} == $symbol && ${sheet[5]} == $symbol && ${sheet[6]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                elif [[ ${sheet[7]} == $symbol && ${sheet[8]} == $symbol && ${sheet[9]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                #CHECKING WITHE COLOUMN

                elif [[ ${sheet[1]} == $symbol && ${sheet[4]} == $symbol && ${sheet[7]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                elif [[ ${sheet[2]} == $symbol && ${sheet[5]} == $symbol && ${sheet[8]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                elif [[ ${sheet[3]} == $symbol && ${sheet[6]} == $symbol && ${sheet[9]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                #CHECKING WITH DIAGONALS

                elif [[ ${sheet[1]} == $symbol && ${sheet[5]} == $symbol && ${sheet[9]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                elif [[ ${sheet[3]} == $symbol && ${sheet[5]} == $symbol && ${sheet[7]} == $symbol ]]
                then
                        echo "====$winner is winner====="
                        exit
                fi
}

#CHECK IF IT IS TIE
Tie() {
        for (( count = 1; count <= 10; count++ ))
        do
                if [ -z "${sheet[count]}" ]
                then
                        break
                else
                        if (( $count == 9 ))
                        then
                                setTheBoard
                                echo "****Game tie****"
                                exit
                        fi
                fi
        done
}



#LETS ASSUME FIRST PLAYER STARTS TO PLAY
playerStarts() {
        echo "****player starts****"
        win="player"
        setTheBoard
        read -p "Mention the position from where player wants to start the game: " playerPosition
        if [ -z "${sheet[$playerPosition]}" ]
        then
                if (( $playerPosition >= 1 && $playerPosition <= 9 ))
                then
                        sheet[$playerPosition]=$playerSymbol
                        #symbol=$playerSymbol
                        setTheBoard
                        checkWinner $playerSymbol $win
                        Tie
                else
                        echo "Not a valid input"
                        playerStarts
                fi
        else

                echo "Not a valid input"
                playerStarts
        fi
}

#COMPUTER STARTS TO PLAY
computerPlay() {
        echo "****computer plays****"
        win2="computer"
        computerPosition=$((1+RANDOM%9))
        if [ -z "${sheet[$computerPosition]}" ]
        then
                sheet[$computerPosition]=$computerSymbol
                setTheBoard
                checkWinner $computerSymbol $win2
                Tie
        else
                computerPlay
        fi
        echo "****computer played****"
}


computerInitiates() {
        for (( box=1;box<10;box++ ))
        do
                if [ -z "${sheet[$box]}" ]
                then
                        sheet[$box]="$computerSymbol"
      echo "computer win check"
                        player="computer"
                        checkWinner $computerSymbol $player
                        sheet[$box]=""

                   if (( $box == 9 ))
                then
                         echo "This does not conclude win, keep playing"
                         opponentBlocking
                        fi
                fi
        done

}
#LETS CREATE A FUNCTION TO BLOCK THE OPPONENT
opponentBlocking() {
        echo "********BLOCKING THE OPPONENT********"
        for (( cell=1;cell<10;cell++ ))
        do
                if [ -z "${sheet[$cell]}" ]
                then
                        sheet[$cell]="$playerSymbol"
                        echo "take a look for player winning condition and if present then blocking them"
                        checkWinningOfOpp "$playerSymbol"
                        sheet[$cell]=""

                        if [ $cell -eq 9 ]
                        then
                                echo "********Do not have any cell for blocking********"

                                cornerPlay
                        fi
                fi
        done
}

#FUNCTION TO DETERMINE CORNER CONDITION
cornerPlay() {
        echo "********corner blocking********"
        if [ -z "${sheet[1]}" ]
        then
                sheet[1]="$computerSymbol"
        elif [ -z "${sheet[3]}" ]
        then
                sheet[3]="$computerSymbol"
        elif [ -z "${sheet[7]}" ]
        then
                sheet[7]="$computerSymbol"
        elif [ -z "${sheet[9]}" ]
        then
                sheet[9]="$computerSymbol"
        else
                echo ********No corner to block********
                centrePlay
        fi
}

#FUNCTION TO DETERMINE CENTRE CONDITION
centreplay() {
        echo "********centre blocking********"
        if [ -z "${board[5]}" ]
        then
                sheet[5]="$computerSymbol"
        else
                echo "********There is no centre to block********"
                echo "********Do random check if any********"
                computerPlay
        fi
}

#ANALYSING PLAYER WINNING CELL FOR BLOCKING
checkWinningOfOpp() {

        symbol2=$1
        if [[ ${sheet[1]} == $symbol2 && ${sheet[2]} == $symbol2 && ${sheet[3]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[4]} == $symbol2 && ${sheet[5]} == $symbol2 && ${sheet[6]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[7]} == $symbol2 && ${sheet[8]} == $symbol2 && ${sheet[9]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[1]} == $symbol2 && ${sheet[4]} == $symbol2 && ${sheet[7]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[2]} == $symbol2 && ${sheet[5]} == $symbol2 && ${sheet[8]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[3]} == $symbol2 && ${sheet[6]} == $symbol2 && ${sheet[9]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[1]} == $symbol2 && ${sheet[5]} == $symbol2 && ${sheet[9]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        elif [[ ${sheet[3]} == $symbol2 && ${sheet[5]} == $symbol2 && ${sheet[7]} == $symbol2 ]]
        then
                sheet[$cell]="$computerSymbol"
                cell=10
        fi
}

#Resume the game
resumeGame() {
        if [ $tossDecision -eq $player ]
        then
                while [ $flag -eq 1 ]
                do
                        playerStarts
                        computerInitiates
                done
        else
                while [ $flag -eq 1  ]
                do
                        computerInitiates
                        playerStarts
                done
        fi
}

toss
letterSymbol
echo "system symbol = $systemSymbol"
echo "player symbol = $playerSymbol"
resumeGame





