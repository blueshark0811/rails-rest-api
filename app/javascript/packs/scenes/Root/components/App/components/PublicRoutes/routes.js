import React from 'react';
//
import ErrorBoundary from 'base_components/ErrorBoundary';
/* for code splitting - loadable */
import Loadable from 'react-loadable';
import Loader from 'base_components/Loader';

const AsyncLogin = Loadable({
  loader: () => import('scenes/Login'),
  loading: Loader, // before this component gets loaded, we will render first this Loader component.
  timeout: 10000
});

const publicRoutes = [
  {
    id: 'public01',
    path: '/login',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the login page.">
        <AsyncLogin {...props} />
      </ErrorBoundary>
    )
  }
];

export default publicRoutes;
