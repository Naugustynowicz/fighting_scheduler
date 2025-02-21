import React, { useEffect, useReducer } from 'react';

let initialTreeBracket = []

export default function TreeBracket({event_id}) {
  const [treeBracket, dispatch] = useReducer(treeBracketReducer, initialTreeBracket);
  const const_event_id = event_id;

  useEffect(() => {
      let ignore = false;
      fetch(`http://localhost:3000/events/${const_event_id}/generate_tree_bracket`, {headers : {'X-CSRF-Token': ''}})
      .then(response => response.json())
      .then(json => {
        if(!ignore){
          dispatch({type: 'fetched', treeBracket: json})
        }
      })
      return () => ignore = true;
    }, [])

  function handleClick() {
    // WIP
  }

  return (
    <>
      {displayTree(treeBracket)}
    </>
  );
}

function buildTree(tree){
  if(!('children' in tree)){
    return (
      {
        matchId: tree['content']['id'],
        user1: tree['content']['user1_id'],
        user2: tree['content']['user2_id']
      }
    )
  }

  return(
    {
      match1: buildTree(tree['children'][0]),
      match2: buildTree(tree['children'][1])
    }
  )
}

function displayTree(tree){
  if(!tree) return;
  if('matchId' in tree){
    return (
      <>
        <p>match: {tree['matchId']}</p>
        <p>user: {tree['user1']}</p>
        <p>user: {tree['user2']}</p>
      </>
    )
  }

  return(
    <>
      <div>tree</div>
      <div>{displayTree(tree['match1'])}</div>
      <div>{displayTree(tree['match2'])}</div>
    </>
  )
}

function treeBracketReducer(treeBracket, action) {
  switch (action.type) {
    case 'fetched': {
      let generatedTreeBracket = buildTree(action.treeBracket)
      return generatedTreeBracket;
    }
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}