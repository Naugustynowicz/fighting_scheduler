import React, { useState } from 'react';
import { useEvents, useEventsDispatch } from '../../contexts/events';
import Attendees from './eventList/attendees';
import EditEvent from './eventList/editEvent';
import TreeBracket from './eventList/treeBracket';

export default function EventList() {
  const events = useEvents();

  return (
    <ul>
      {events.map(event => (
        <li key={event.id}>
          <Event event={event} />
        </li>
      ))}
    </ul>
  );
}

function Event({ event }) {
  const [isEditing, setIsEditing] = useState('');
  const dispatch = useEventsDispatch();
  let eventContent;
  if (isEditing === 'event') {
    eventContent = (
      <EditEvent event={event} />
    )
  } else if (isEditing === 'attendees') {
    eventContent = (
      <Attendees event_id={event.id} />
    )
  } else if (isEditing === 'bracket') {
    eventContent = (
      <TreeBracket event_id={event.id} />
    )
  } else {
    eventContent = (
      <>
        <p>{event.startDate}</p>
        <p>{event.endDate}</p>
        <p>{event.attendeesNb}</p>
        <p>{event.venueFee}</p>
        <p>{event.requiredScore}</p>
        <h2>{event.name}</h2>
        <p>{event.description}</p>
        <p>{event.rules}</p>
        <p>{event.schedule}</p>
        <p>{event.brackets}</p>
        <p>{event.userId}</p>
        <p>{event.statusId}</p>
        <p>{event.locationId}</p>
        <p>{event.sportId}</p>
        <p>{event.typeEventId}</p>
      </>
    );
  }

  return (
    <label>
      {eventContent}
      <button onClick={() => {
          setIsEditing('')
      }}>
          Event
      </button>
      <button onClick={() => {
          setIsEditing('event')
      }}>
          Edit
      </button>
      <button onClick={() => {
          setIsEditing('attendees')
      }}>
          Attendees
      </button>
      <button onClick={() => { 
        dispatch({ type: 'subscribed', id: event.id })
        setIsEditing('attendees')
      }}>
        Subscribe
      </button>
      <button onClick={() => {
          setIsEditing('bracket')
      }}>
        Bracket
      </button>
      <button onClick={() => dispatch(
        { type: 'deleted', id: event.id }
      )}>
        Delete
      </button>
    </label>
  );
}