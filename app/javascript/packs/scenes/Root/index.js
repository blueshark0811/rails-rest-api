import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { ConnectedRouter } from 'react-router-redux';
import { BreadcrumbsProvider } from 'react-breadcrumbs-dynamic/dist/src';
// importing store and history
import store, { history } from 'store';

import AppContainer from './components/App';

class Root extends Component {
  render() {
    return (
      <Provider store={store}>
        <ConnectedRouter history={history}>
          <BreadcrumbsProvider>
            <AppContainer />
          </BreadcrumbsProvider>
        </ConnectedRouter>
      </Provider>
    );
  }
}

export default Root;
