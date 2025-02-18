import React, { createContext, useContext, useReducer, useEffect } from 'react';

export const SportsContext = createContext(null);
export const SportsDispatchContext = createContext(null);

let initialSports = [
  {
    id: 1,
    name: 'Sport1',
    description: 'This is a description',
    status: 'public'
  },
  {
    id: 2,
    name: 'Sport2',
    description: "It's one too",
    status: 'public'
  },
]

export function SportsProvider({ children }){
  const [sports, dispatch] = useReducer(sportsReducer, initialSports);

  // WIP
  // useEffect(() => {
  //   let ignore = false;
  // 
  //   async function startFetching() {
  //     const json = await fetch('http://localhost:3000/sports');
  //     if (!ignore) {
  //       // setTodos(json);
  //     }
  //   }
  // 
  //   startFetching();
  // 
  //   return () => {
  //     ignore = true;
  //   };
  // }, []);

  useEffect(() => {
    let ignore = false;
    fetch('http://localhost:3000/sports')
      .then(response => response.json())
      .then(
        json => {
          if(!ignore){
            dispatch({type: 'fetched', sports: json})
          }
        }
      )
    return () => ignore = true;
  }, [])

  return(
    <SportsContext.Provider value={sports}>
      <SportsDispatchContext.Provider value={dispatch}>
        { children }
      </SportsDispatchContext.Provider>
    </SportsContext.Provider>
  )
}

export function useSports() {
  return useContext(SportsContext);
}

export function useSportsDispatch() {
  return useContext(SportsDispatchContext);
}

function sportsReducer(sports, action) {
  switch (action.type) {
    case 'fetched': {
      return [...action.sports];
    }
    case 'added': {
      // fetch('http://localhost:3000/sports', { method: 'POST', body: {
      //   id: action.id,
      //   name: action.name,
      //   description: action.description,
      //   status: 'public'
      // } });
      //
      // // alternative
      // post(('http://localhost:3000/sports', {
      //   id: action.id,
      //   name: action.name,
      //   description: action.description,
      //   status: 'public'
      // })

      return [
        ...sports,
        {
          id: action.id,
          name: action.name,
          description: action.description,
          status: 'public'
        },
      ];
    }
    case 'changed': {
      return sports.map((sport) => {
        if (sport.id === action.sport.id) {
          // fetch('http://localhost:3000/sports', { method: 'PATCH', body: {
          //   id: action.id,
          //   name: action.name,
          //   description: action.description,
          //   status: 'public'
          // } });

          return action.sport;
        } else {
          return sport;
        }
      });
    }
    case 'deleted': {
      // fetch('http://localhost:3000/sports', { method: 'DELETE', body: {
      //   id: action.id
      // } });

      return sports.filter((sport) => sport.id !== action.id);
    } 
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}

