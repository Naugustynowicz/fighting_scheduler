import React, { useEffect, useReducer } from 'react';

let initialAttendees = [
  {
    id: 1,
    name: 'Attendee1',
    other: 'This is a description',
    position: 'WIP',
    firstTeam: 'WIP'
  },
  {
    id: 2,
    name: 'Attendee2',
    other: "It's one too",
    position: 'WIP',
    firstTeam: 'WIP'
  },
]

export default function Attendees({event_id}) {
  const [attendees, dispatch] = useReducer(attendeesReducer, initialAttendees);
  const const_event_id = event_id;

  useEffect(() => {
      let ignore = false;
      fetch(`http://localhost:3000/events/${const_event_id}/attendees`)
      .then(response => response.json())
      .then(json => {
        if(!ignore){
          dispatch({type: 'fetched', attendees: json})
        }
      })
      return () => ignore = true;
    }, [])

  return (
    <section>
      <div class='container'>
      <ul>
        {attendees.map(attendee => (
          <li key={attendee.id}>{attendee.name}
            <text>{attendee.other}</text>
          </li>
        ))}
      </ul>
      </div>
    </section>
  );
}

function attendeesReducer(attendees, action) {
  switch (action.type) {
    case 'fetched': {
      let fetchedAttendees = action.attendees.map((fetchedAttendee) => {
        return (
          {
            id: fetchedAttendee.id,
            name: fetchedAttendee.name,
            other: fetchedAttendee.other,
            position: fetchedAttendee.position,
            firstTeam: fetchedAttendee.firstTeam
          }
        )
      })
      return [...fetchedAttendees];
    }
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}