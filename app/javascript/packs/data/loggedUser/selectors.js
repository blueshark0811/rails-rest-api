import { createSelector } from 'reselect';
import { isEmpty, compose, not } from 'ramda';

// get loggedUser
export const selectLoggedUser = state => state.loggedUser.user;

// select logged user proccess error
const selectProcessError = state => state.loggedUser.processRequest.error;

// get error message
export const getErrorMessage = createSelector(
  selectProcessError,
  error => (isEmpty(error) ? error : error.message)
);

/**
 * isUserValid :: Object -> Boolean
 *
 * Check if the user is valid using error message
 * @param{Object} state
 * @return{Boolean}
 */
export const isUserValid = createSelector(getErrorMessage, isEmpty);

/**
 * isUserAuthenticated :: Object -> Boolean
 *
 * Check if the user isAuthenticated through checking the user value.
 * @param{Object} state
 * @return{Boolean}
 */
export const isUserAuthenticated = createSelector(
  selectLoggedUser,
  compose(not, isEmpty)
);
