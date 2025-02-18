export default function sportsReducer(sports, action) {
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