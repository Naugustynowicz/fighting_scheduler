import React, { createContext, useContext, useReducer } from 'react';

export const SportsContext = createContext(null);
export const SportsDispatchContext = createContext(null);

const initialSports = [
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
    case 'added': {
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
          return action.sport;
        } else {
          return sport;
        }
      });
    }
    case 'deleted': {
      return sports.filter((sport) => sport.id !== action.id);
    } 
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}

