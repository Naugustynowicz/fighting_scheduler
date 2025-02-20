import React, { useState } from 'react';
import { useEvents, useEventsDispatch } from '../../contexts/events';
import Attendees from './attendees';
import TreeBracket from './treeBracket';

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
  const [isEditing, setIsEditing] = useState(false);
  const dispatch = useEventsDispatch();
  let eventContent;
  if (isEditing) {
    eventContent = (
      <>
        <input
          value={event.startDate}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                startDate: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.endDate}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                endDate: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.attendeesNb}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                attendeesNb: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.venueFee}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                venueFee: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.requiredScore}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                requiredScore: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.name}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                name: e.target.value
              }
            });
          }} 
        />
        <input
          type='text'
          value={event.description}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                description: e.target.value
              }
            });
          }} 
        />
        <input
          type='text'
          value={event.rules}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                rules: e.target.value
              }
            });
          }} 
        />
        <input
          type='text'
          value={event.schedule}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                schedule: e.target.value
              }
            });
          }} 
        />
        <input
          type='text'
          value={event.brackets}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                brackets: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.userId}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                userId: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.statusId}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                statusId: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.locationId}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                locationId: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.sportId}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                sportId: e.target.value
              }
            });
          }} 
        />
        <input
          value={event.typeEventId}
          onChange={e => {
            dispatch({
              type: 'changed',
              event: {
                ...event,
                typeEventId: e.target.value
              }
            });
          }} 
        />
        <button onClick={() => {
          dispatch({
            type: 'commitChanges',
            id: event.id,
            startDate: event.startDate,
            endDate: event.endDate,
            attendeesNb: event.attendeesNb,
            venueFee: event.venueFee,
            requiredScore: event.requiredScore,
            name: event.name,
            description: event.description,
            rules: event.rules,
            schedule: event.schedule,
            brackets: event.brackets,
            userId: event.userId,
            statusId: event.statusId,
            locationId: event.locationId,
            sportId: event.sportId,
            typeEventId: event.typeEventId
          });
          setIsEditing(false)
        }}>
          Save
        </button>
      </>
    );
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
        <button onClick={() => {
          setIsEditing(true)
        }}>
          Edit
        </button>
      </>
    );
  }

  return (
    <label>
      {eventContent}
      <Attendees event_id={event.id} />
      <TreeBracket event_id={event.id} />
      <button onClick={() => dispatch(
        {
          type: 'subscribed',
          id: event.id
        }
      )}>
        Subscribe
      </button>
      <button onClick={() => dispatch(
        {
          type: 'deleted',
          id: event.id
        }
      )}>
        Delete
      </button>
    </label>
  );
}