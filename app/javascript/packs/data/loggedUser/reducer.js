import {
  PENDING_REQUEST,
  SUCCESS_REQUEST,
  FAILURE_REQUEST,
  ADD_LOGGED_USER,
  REMOVE_LOGGED_USER
} from './actionTypes';
import { combineReducers } from 'redux';

// reducers for process
const processRequest = (
  state = {
    pending: false,
    success: false,
    error: ''
  },
  action
) => {
  switch (action.type) {
    case PENDING_REQUEST: {
      const { isPending } = action.payload;
      return {
        ...state,
        pending: isPending
      };
    }
    case SUCCESS_REQUEST: {
      const { isPending } = action.payload;
      return {
        ...state,
        pending: isPending,
        success: true,
        error: ''
      };
    }
    case FAILURE_REQUEST: {
      const { isPending, error } = action.payload;
      return {
        ...state,
        pending: isPending,
        error: error
      };
    }
    default: {
      return state;
    }
  }
};

/**
 * user :: (state, action) -> state
 *
 * Managing the state of loggedUser. LoggedUser will hold either a userID or null.
 */
const user = (state = {}, action) => {
  switch (action.type) {
    case ADD_LOGGED_USER: {
      const { loggedUser } = action.payload;
      return loggedUser;
    }
    case REMOVE_LOGGED_USER: {
      return {};
    }
    default: {
      return state;
    }
  }
};

export default combineReducers({
  processRequest,
  user
});
