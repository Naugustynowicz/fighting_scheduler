import React, { useState } from "react";
import SportUpdate from "./sports/update";

export default function Sports(){
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

  const [sportList, setSportList] = useState(initialSportList);

  const listItems = sportList.map(sport =>
    <li key={sport.id}>
      <h2>{sport.name}</h2>
      <p>
        {sport.description}
      </p>
      <SportUpdate sportInit={sport} />
    </li>
  );

  return(
    <>
    <h1>List of sports</h1>
    <ul>{listItems}</ul>
    </>
  )

  // <SportCreate sportList={sportList} setSportList={setSportList} />
}


