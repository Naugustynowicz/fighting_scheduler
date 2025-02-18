import React, { useState } from 'react';
import { useSports, useSportsDispatch } from '../../contexts/sports';

export default function SportList() {
  const sports = useSports();

  return (
    <ul>
      {sports.map(sport => (
        <li key={sport.id}>
          <Sport sport={sport} />
        </li>
      ))}
    </ul>
  );
}

function Sport({ sport }) {
  const [isEditing, setIsEditing] = useState(false);
  const dispatch = useSportsDispatch();
  let sportContent;
  if (isEditing) {
    sportContent = (
      <>
        <input
          value={sport.name}
          onChange={e => {
            dispatch({
              type: 'changed',
              sport: {
                ...sport,
                name: e.target.value
              }
            });
          }} />
          <input
          type='text'
          value={sport.description}
          onChange={e => {
            dispatch({
              type: 'changed',
              sport: {
                ...sport,
                description: e.target.value
              }
            });
          }} />
        <button onClick={() => setIsEditing(false)}>
          Save
        </button>
      </>
    );
  } else {
    sportContent = (
      <>
        <h2>{sport.name}</h2>
        <p>
          {sport.description}
        </p>
        <button onClick={() => setIsEditing(true)}>
          Edit
        </button>
      </>
    );
  }

  return (
    <label>
      {sportContent}
      <button onClick={() => dispatch(
        {
          type: 'deleted',
          id: sport.id
        }
      )}>
        Delete
      </button>
    </label>
  );
}