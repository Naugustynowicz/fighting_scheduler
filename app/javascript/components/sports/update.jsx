import React, { useState } from "react";

export default function SportUpdate() {
  const [sport, setSport] = useState({
    name: 'Sport1',
    description: 'This is a description',
    status: 'public'
  });

  function handleNameChange(e) {
    setSport({
      ...sport,
      name: e.target.value
    });
  }

  function handleDescriptionChange(e) {
    setSport({
      ...sport,
      description: e.target.value
    });
  }

  function handleStatusChange(e) {
    setSport({
      ...sport,
      status: e.target.value
    });
  }

  return (
    <>
      <label>
        Name:
        <input
          value={sport.name}
          onChange={handleNameChange}
        />
      </label>
      <label>
        description:
        <input type='text'
          value={sport.description}
          onChange={handleDescriptionChange}
        />
      </label>
      <label>
        status:
        <input
          value={sport.email}
          onChange={handleStatusChange}
        />
      </label>
      <p>
        {sport.name}{' '}
        {sport.description}{' '}
        ({sport.status})
      </p>
    </>
  );
}

