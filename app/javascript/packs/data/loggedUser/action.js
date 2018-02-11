import {
  PENDING_REQUEST,
  SUCCESS_REQUEST,
  FAILURE_REQUEST,
  ADD_LOGGED_USER,
  REMOVE_LOGGED_USER
} from './actionTypes';
import { fetchUser } from './api';

// Requests action creators.
// begin the request, status type - PENDING
const pending = () => ({
  type: PENDING_REQUEST,
  payload: {
    isPending: true
  }
});
// success, status type - SUCCESS
const success = () => ({
  type: SUCCESS_REQUEST,
  payload: {
    isPending: false
  }
});
// failure, status type - failure
const failure = error => ({
  type: FAILURE_REQUEST,
  payload: {
    isPending: false,
    error
  }
});

/**
 * addLoggedUser :: Object -> Object
 *
 * Action creator for setting the logged user.
 * @param {Object} loggedUser
 * @return {Object}
*/
const addLoggedUser = loggedUser => ({
  type: ADD_LOGGED_USER,
  payload: {
    loggedUser
  }
});

/**
 * loggedUser :: Object -> Function
 *
 * Action creator for firing a request to login user.
 * @param {Object} account user account
 * @return {Function}
 */
export const loggedUser = account => dispatch => {
  // dispatch pending AC
  dispatch(pending());
  // execute the loggingUser api
  // we can return the promise once the async dispatch function execute.
  return fetchUser(account)
    .then(data => {
      // dispatch success AC
      dispatch(success());
      // dispatch addLoggedUser AC
      dispatch(addLoggedUser(data.user));
      return data;
    })
    .catch(err => {
      dispatch(failure(err));
      return err;
    });
};

export const removeLoggedUser = () => ({
  type: REMOVE_LOGGED_USER
});
