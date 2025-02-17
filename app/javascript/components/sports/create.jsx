import React, { useState } from "react";

const [answer, setAnswer] = useState('');
const [error, setError] = useState(null);
const [status, setStatus] = useState('typing'); // 'typing', 'submitting', or 'success'

export default function SportCreate() {
  const [sport, setSport] = useState({
    name: 'Sport1',
    description: 'This is a description',
    status: 'public'
  });

  

  return(
    <></>
  )
}