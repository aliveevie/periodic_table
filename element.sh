PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
# Check for empty argument
if [[ $# -eq 0 ]]
    then
echo "Please provide an element as an argument."
    else
     ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements")
     SYMBOL=$($PSQL "SELECT symbol FROM elements")
     NAME=$($PSQL "SELECT name FROM elements")

    if [[ $ATOMIC_NUMBER =~ $1 || $SYMBOL =~ $1 || $NAME =~ $1 ]]
        then
      
           if [[ $ATOMIC_NUMBER =~ $1 ]]
             then
                export ATM
                ATM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
                SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
                NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
                MASS_NUM=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
                TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = $1")
                MPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
                BPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
            elif [[ $SYMBOL =~ $1 ]]
                then
                ATM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
                SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol= '$1'")
                NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
                MASS_NUM=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1'")
                TYPE=$($PSQL "SELECT type FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1'")
                MPC=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1'")
                BPC=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol = '$1'")
           
           elif [[ $NAME =~ $1 ]]
                then
                ATM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
                SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
                NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
                MASS_NUM=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1'")
                TYPE=$($PSQL "SELECT type FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1'")
                MPC=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1'")
                BPC=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name = '$1'")
           
                
           fi
           echo "The element with atomic number $ATM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS_NUM amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
           else
            echo "I could not find that element in the database."
        fi
      
fi
