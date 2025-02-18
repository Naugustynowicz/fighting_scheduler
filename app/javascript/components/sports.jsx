import React, { useReducer } from "react";
import sportsReducer from "../reducers/sports";
import AddSport from "./sports/addSport";
import SportList from "./sports/sportList";


export default function Sports(){
  let nextId = 3;
  const initialSportList = [
    {
      id: 1,
      name: 'Sport1',
      description: 'This is a description',
      status: 'public'
    },
    {
      id: 2,
      name: 'Sport2',
      description: "It's one too",
      status: 'public'
    },
  ]

  function handleAddSport({name, description}) {
    dispatch({
      type: 'added',
      id: nextId++,
      name: name,
      description: description
    });
  }

  function handleChangeSport(sport){
    dispatch({
      type: 'changed',
      sport: sport,
    });
  }

  function handleDeleteSport(sportId){
    dispatch({
      type: 'deleted',
      id: sportId,
    });
  }

  const [sports, dispatch] = useReducer(sportsReducer, initialSportList);

  return (
    <>
      <h1>Sports' list</h1>
      <AddSport
        onAddSport={handleAddSport}
      />
      <SportList
        sports={sports}
        onChangeSport={handleChangeSport}
        onDeleteSport={handleDeleteSport}
      />
    </>
  );
}



