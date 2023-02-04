#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument."
else
 if [[ $1 =~ ^[0-9]+$ ]]
 then
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
  if [[ -z $NAME ]]
  then
    echo -e "I could not find that element in the database."
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
    TYPE=$($PSQL "SELECT type FROM types RIGHT JOIN properties ON types.type_id = properties.type_id WHERE atomic_number = $1")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
    MELTINGP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
    BOILINGP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
    NAME_F=$(echo $NAME | sed -r 's/^ *| *$//g')
    SYMBOL_F=$(echo $SYMBOL | sed -r 's/^ *| *$//g')
    TYPE_F=$(echo $TYPE | sed -r 's/^ *| *$//g')
    MASS_F=$(echo $MASS | sed -r 's/^\t*| *$//g')
    MELTINGP_F=$(echo $MELTINGP | sed -r 's/^\t*| *$//g')
    BOILINGP_F=$(echo $BOILINGP | sed -r 's/^\t*| *$//g')
    echo "The element with atomic number $1 is $NAME_F ($SYMBOL_F). It's a $TYPE_F, with a mass of $MASS_F amu. $NAME_F has a melting point of $MELTINGP_F celsius and a boiling point of $BOILINGP_F celsius."
  fi
 else
  # Input wasn't a number
  n=${#1}
  if [[ $n < 3 ]]
  then
    # First case, the user gave us the element symbol.
    ANUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    if [[ -z $ANUMBER ]]
    then 
      echo "I could not find that element in the database."
    else
      # We proceed
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
      TYPE=$($PSQL "SELECT type FROM types RIGHT JOIN properties ON types.type_id = properties.type_id WHERE atomic_number = $ANUMBER")
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ANUMBER")
      MELTINGP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ANUMBER")
      BOILINGP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ANUMBER")
      NAME_F=$(echo $NAME | sed -r 's/^ *| *$//g')
      SYMBOL_F=$(echo $1 | sed -r 's/^ *| *$//g')
      TYPE_F=$(echo $TYPE | sed -r 's/^ *| *$//g')
      MASS_F=$(echo $MASS | sed -r 's/^\t*| *$//g')
      MELTINGP_F=$(echo $MELTINGP | sed -r 's/^\t*| *$//g')
      BOILINGP_F=$(echo $BOILINGP | sed -r 's/^\t*| *$//g')
      ANUMBER_F=$(echo $ANUMBER | sed -r 's/^\t*| *$//g')
      echo "The element with atomic number $ANUMBER_F is $NAME_F ($SYMBOL_F). It's a $TYPE_F, with a mass of $MASS_F amu. $NAME_F has a melting point of $MELTINGP_F celsius and a boiling point of $BOILINGP_F celsius."
    fi
  else
    # We are in the second case, input lenght more than 2.
    ANUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    if [[ -z $ANUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      # We proceed
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ANUMBER")
      TYPE=$($PSQL "SELECT type FROM types RIGHT JOIN properties ON types.type_id = properties.type_id WHERE atomic_number = $ANUMBER")
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ANUMBER")
      MELTINGP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ANUMBER")
      BOILINGP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ANUMBER")
      NAME_F=$(echo $1 | sed -r 's/^ *| *$//g')
      SYMBOL_F=$(echo $SYMBOL | sed -r 's/^ *| *$//g')
      TYPE_F=$(echo $TYPE | sed -r 's/^ *| *$//g')
      MASS_F=$(echo $MASS | sed -r 's/^\t*| *$//g')
      MELTINGP_F=$(echo $MELTINGP | sed -r 's/^\t*| *$//g')
      BOILINGP_F=$(echo $BOILINGP | sed -r 's/^\t*| *$//g')
      ANUMBER_F=$(echo $ANUMBER | sed -r 's/^\t*| *$//g')
      echo "The element with atomic number $ANUMBER_F is $NAME_F ($SYMBOL_F). It's a $TYPE_F, with a mass of $MASS_F amu. $NAME_F has a melting point of $MELTINGP_F celsius and a boiling point of $BOILINGP_F celsius."

    fi
  fi
 fi
fi
