import React, { useEffect, useReducer } from 'react';
import CSRFToken from '../../cookies';

let initialTreeBracket = []

export default function TreeBracket({event_id}) {
  const [treeBracket, dispatch] = useReducer(treeBracketReducer, initialTreeBracket);
  const const_event_id = event_id;

  useEffect(() => {
      let ignore = false;
      fetch(`http://localhost:3000/events/${const_event_id}/display_tree_bracket`)
      .then(response => response.json())
      .then(json => {
        if(!ignore){
          dispatch({type: 'fetched', treeBracket: json})
        }
      })
      return () => ignore = true;
    }, [treeBracket])

    function displayTree(tree){
      if(!tree) return;
      let displayedId = (
        <>
          <div>id: {tree['id']}</div>
          <button onClick={() => { dispatch({ type: 'updateMatch', match_id: tree['id'] }); }}>
            update match
          </button> 
        </>
      )
      let displayedWinner = (<></>)
      if('winner_id' in tree){
        displayedWinner = (
          <div>winner_id: {tree['winner_id']}</div>
        )
      }
      let displayedUser1 = (<></>)
      if('user1_id' in tree){
        displayedUser1 = (
          <>
            <div>user1_id: {tree['user1_id']}</div>
            <button onClick={() => { dispatch({ type: 'setWinner', match_id: tree['id'], winning_user_id: tree['user1_id'] }); }}> 
              Set as winner 
            </button>
            <div>user1_name: {tree['user1_name']}</div>
            <div>user1_email: {tree['user1_email']}</div>
          </>
        )
      }
      let displayedUser2 = (<></>)
      if('user2_id' in tree){
        displayedUser2 = (
          <>
            <div>user2_id: {tree['user2_id']}</div>
            <button onClick={() => { dispatch({ type: 'setWinner', match_id: tree['id'], winning_user_id: tree['user2_id'] }); }}> 
              Set as winner 
            </button>
            <div>user2_name: {tree['user2_name']}</div>
            <div>user2_email: {tree['user2_email']}</div>
          </>
        )
      }
      let displayedSubmatch1 = (<></>)
      if('submatch1' in tree){
        displayedSubmatch1 = displayTree(tree.submatch1)
      }
      let displayedSubmatch2 = (<></>)
      if('submatch2' in tree){
        displayedSubmatch2 = displayTree(tree.submatch2)
      }
    
      return(
        <section class='section-tree'>
          <div class='container-tree'>
            <ul class='ul-tree'>
            {displayedSubmatch1}
            {displayedId}
            {displayedWinner}
            {displayedUser1}
            {displayedUser2}
            {displayedSubmatch2}
            </ul>
          </div>
        </section>
      )
    }

  return (
    <>
      {displayTree(treeBracket)}
      <button onClick={() => { dispatch({ type: 'generateTreeBracket', event_id: const_event_id }); }}>
        generate bracket
      </button> 
    </>
  );
}

function buildFetchedTree(fetchedTree){
  let buildedFetchedTree = {
    id: fetchedTree.match.id,
  }
  if('winner_id' in fetchedTree.match){
    buildedFetchedTree = {
      ...buildedFetchedTree,
      winner_id: fetchedTree.match.winner_id
    }
  }
  if('user1' in fetchedTree && fetchedTree.user1 !== null){
    buildedFetchedTree = {
      ...buildedFetchedTree,
      user1_id: fetchedTree.match.user1_id,
      user1_name: fetchedTree.user1.name,
      user1_email: fetchedTree.user1.email,
    }
  }
  if('user2' in fetchedTree && fetchedTree.user2 !== null){
    buildedFetchedTree = {
      ...buildedFetchedTree,
      user2_name: fetchedTree.user2.name,
      user2_email: fetchedTree.user2.email,
      user2_id: fetchedTree.match.user2_id,
    }
  }
  if('submatch1' in fetchedTree){
    buildedFetchedTree = {
      ...buildedFetchedTree,
      submatch1: buildFetchedTree(fetchedTree.submatch1) 
    }
  }
  if('submatch2' in fetchedTree){
    buildedFetchedTree = {
      ...buildedFetchedTree,
      submatch2: buildFetchedTree(fetchedTree.submatch2) 
    }
  }

  return buildedFetchedTree;
}



function treeBracketReducer(treeBracket, action) {
  switch (action.type) {
    case 'fetched': {
      let generatedTreeBracket = buildFetchedTree(action.treeBracket)
      return generatedTreeBracket;
    }
    case 'generateTreeBracket': {
      fetch(`http://localhost:3000/events/${action.event_id}/generate_tree_bracket`)
      return;
    }
    case 'setWinner': {
      let changedMatch = { match: {
        winner: action.winning_user_id
      }}
      fetch(`http://localhost:3000/matches/${action.match_id}/determine_winner`, { 
        method: 'PATCH', 
        headers: { 'Content-Type': 'application/json', "X-CSRF-Token": CSRFToken(document.cookie) },
        body: JSON.stringify(changedMatch)
      });
      return;
    }
    case 'updateMatch': {
      fetch(`http://localhost:3000/matches/${action.match_id}/update_match`)
      return;
    }
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}