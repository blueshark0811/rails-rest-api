import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { Switch, Route } from 'react-router-dom';
import { identical } from 'ramda';
/* for code splitting - loadable */
import Loadable from 'react-loadable';
import Loader from 'base_components/Loader';
//
import Main from 'base_components/Main';
import createRoute from '../createRoute';
import routes from './routes';

/* create our async component in here
 * this will optimize the loading of components of our app
 * dynamically importing our scenes here*/
const AsyncMainBars = Loadable({
  loader: () => import('scenes/components/SidebarTransition'),
  loading: () => null, // before this component gets loaded, we will render first this Loader component.
  timeout: 10000
});

const AsyncNavbarAdmin = Loadable({
  loader: () => import('scenes/components/NavbarAdmin'),
  loading: Loader,
  timeout: 10000
});

const AsyncNotFound = Loadable({
  loader: () => import('scenes/NotFound'),
  loading: Loader,
  timeout: 10000
});

const PrivateRoutes = ({ type }) => (
  <Fragment>
    {/* Displaying the Navbar and Sidebar */}
    <Route
      path="/"
      render={() =>
        // conditional rendering.
        identical(type, 'Student') || identical(type, 'Teacher') ? (
          <AsyncMainBars />
        ) : (
          <AsyncNavbarAdmin />
        )}
    />
    <Main type={type}>
      {/* Routes that our app use. */}
      <Switch>
        {routes.map(route => createRoute(route))}
        <Route component={AsyncNotFound} />
      </Switch>
    </Main>
  </Fragment>
);

PrivateRoutes.propTypes = {
  type: PropTypes.string
};

export default PrivateRoutes;
