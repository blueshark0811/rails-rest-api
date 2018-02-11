import { compose } from 'ramda';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import App from './App';
// selectors
import { loggedUserSelectors } from 'data/loggedUser';

// destructuring loggedUser selectors
const { isUserAuthenticated } = loggedUserSelectors;

const mapState = state => ({
  loggedUser: state.loggedUser.user,
  isUserAuthenticated: isUserAuthenticated(state)
});

export default compose(withRouter, connect(mapState, null))(App);

/**
  Tasks:
    1. Add clearForm functionality. Finished
    2. Add autofocus.
    3. When user is not logged in, redirect to login page. Finished
    4. When is user logged in. This user cannot navigate the login page. When he/she tries to navigate
       we will redirect him/her to index page. Finished
    5. Add logout functionality. Finished
    6. We need to move the Sidebar, SidebarTransition, Navbar, and NavbarAdmin components from base_components to Scenes/components directory.
 */
