import React, { useState } from 'react';

export default function AddSport({ onAddSport }) {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  return (
    <>
      <input
        placeholder="name"
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <input
        type='text'
        placeholder="description"
        value={description}
        onChange={e => setDescription(e.target.value)}
      />
      <button onClick={() => {
        setName('');
        setDescription('');
        onAddSport({name, description});
      }}>Add</button>
    </>
  )
}