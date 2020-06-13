#!/bin/bash -x

player=1;
computer=0;

#TOSS BEFORE THE GAME

#lets take a function for toss
toss() {
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
