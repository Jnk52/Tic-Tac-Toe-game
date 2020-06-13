#!/bin/bash

echo "Welcome to the Tic Tac Toe game"
#declaring the array for board positions
sheet=(1 2 3 4 5 6 7 8 9)
number=0
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
