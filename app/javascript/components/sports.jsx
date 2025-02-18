import React from "react";
import { SportsProvider } from "../contexts/sports";
import AddSport from "./sports/addSport";
import SportList from "./sports/sportList";


export default function Sports(){
  return (
    <SportsProvider>
      <h1>Sports' list</h1>
      <AddSport />
      <SportList />
    </SportsProvider>
  );
}



