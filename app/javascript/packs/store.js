import { createStore, applyMiddleware, compose } from 'redux';
import { routerMiddleware } from 'react-router-redux';
// middlewares
import thunk from 'redux-thunk';
import logger from 'redux-logger';
import createHistory from 'history/createBrowserHistory';
import rootReducer from './reducer';

// Our history syncs our browserHistory with our store and must be exported so we can use it within our routes later.
const history = createHistory();
// initial state.
const initialState = {};
// enhancers, we will use this for dev tools extension.
const enhancers = [];
// these are middlewares.
const middleware = [thunk, routerMiddleware(history), logger];

// we will use dev tools if and only if the environment is on development.
if (process.env.NODE_ENV === 'development') {
  const devToolsExtension = window.devToolsExtension;

  if (typeof devToolsExtension === 'function') {
    enhancers.push(devToolsExtension());
  }
}

const composedEnhancers = compose(
  applyMiddleware(...middleware), // it returs store enhancer
  ...enhancers
);

// creating store.
const store = createStore(rootReducer, initialState, composedEnhancers);

// exposing store on browser
window.store = store;

export { store as default, history };
