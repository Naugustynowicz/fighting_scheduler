import React, { useState } from 'react';

export default function SportList({
  sports,
  onChangeSport,
  onDeleteSport
}) {
  return (
    <ul>
      {sports.map(sport => (
        <li key={sport.id}>
          <Sport
            sport={sport}
            onChange={onChangeSport}
            onDelete={onDeleteSport}
          />
        </li>
      ))}
    </ul>
  );
}

function Sport({ sport, onChange, onDelete }) {
  const [isEditing, setIsEditing] = useState(false);
  let sportContent;
  if (isEditing) {
    sportContent = (
      <>
        <input
          value={sport.name}
          onChange={e => {
            onChange({
              ...sport,
              name: e.target.value
            });
          }} />
          <input
          type='text'
          value={sport.description}
          onChange={e => {
            onChange({
              ...sport,
              description: e.target.value
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
      <button onClick={() => onDelete(sport.id)}>
        Delete
      </button>
    </label>
  );
}