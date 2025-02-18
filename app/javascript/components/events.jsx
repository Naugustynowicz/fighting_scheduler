import React from "react";
import { EventsProvider } from "../contexts/events";
import AddEvent from "./events/addEvent";
import EventList from "./events/eventList";


export default function Events(){
  return (
    <EventsProvider>
      <h1>Events' list</h1>
      <AddEvent />
      <EventList />
    </EventsProvider>
  );
}



