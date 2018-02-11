import React from 'react';
import { Route, Switch } from 'react-router-dom';
/* for code splitting - loadable */
import Loadable from 'react-loadable';
import Loader from 'base_components/Loader';
//
import routes from './routes';
import createRoute from '../createRoute';

const AsyncNotFound = Loadable({
  loader: () => import('scenes/NotFound'),
  loading: Loader,
  timeout: 10000
});

const PublicRoutes = () => (
  <Switch>
    {routes.map(route => createRoute(route))}
    <Route component={AsyncNotFound} />
  </Switch>
);

export default PublicRoutes;
