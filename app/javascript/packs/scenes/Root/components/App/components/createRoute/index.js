import React from 'react';
import { Route } from 'react-router-dom';
import { isNil } from 'ramda';

/**
 * Function which create a route based on the passed route info.
 * @param{Object} route
 * @return{Object} Route component
 */
const createRoute = (route, type) => (
  <Route
    key={route.id}
    path={route.path}
    exact={route.exact}
    strict={route.strict}
    component={!isNil(route.AsyncComponent) ? route.AsyncComponent : null}
    render={
      !isNil(route.AsyncRenderComponent) ? route.AsyncRenderComponent : null
    }
  />
);

export default createRoute;
