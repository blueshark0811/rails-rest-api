import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
//
import Profile from './Profile';
import { loggedUserActions, loggedUserSelectors } from 'data/loggedUser';

// destructuring
const { removeLoggedUser } = loggedUserActions;
const { selectLoggedUser } = loggedUserSelectors;

const mapState = state => ({
  name: selectLoggedUser(state).name,
  avatar: selectLoggedUser(state).avatar
});

const mapDispatch = dispatch =>
  bindActionCreators(
    {
      removeLoggedUser
    },
    dispatch
  );

export default connect(mapState, mapDispatch)(Profile);
