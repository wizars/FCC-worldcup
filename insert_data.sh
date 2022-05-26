#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # si no es la linea de cabeceras
  if [[ $YEAR != year ]]
  then
      # get winner id if the already exists
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      if [[ -z $WINNER_ID ]]
      then      
        # insert new row with winner
        INS_RESULT=$($PSQL "INSERT INTO teams(name) values('$WINNER')")
        # cheack if inserted
        if [[ $INS_RESULT == 'INSERT 0 1' ]]
        then
          echo Fila insertada con un winner
          WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

        fi
      fi

      # get winner and opponent id if the already exists
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      if [[ -z $OPPONENT_ID ]]
      then      
        # insert new row with winner
        INS_RESULT = $($PSQL "INSERT INTO teams(name) values('$OPPONENT')")
        # cheack if inserted
        if [[ $INS_RESULT == 'INSERT 0 1' ]]
        then
          echo Fila insertada on un looser
          OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

        fi
      fi

     # insert the game
      
        # insert new row
        INS_RESULT = $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS )")
        # cheack if inserted
        if [[ $INS_RESULT == 'INSERT 0 1' ]]
        then
          echo Fila insertada on un looser
        fi
  fi
done

