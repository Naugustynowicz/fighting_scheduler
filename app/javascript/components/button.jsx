import React from "react";

export default function Button() {
  function handleClick(){
    alert('Clicked!');
  }

  return (
    <button onClick={handleClick}>
      Click me please!
    </button>
  );
}