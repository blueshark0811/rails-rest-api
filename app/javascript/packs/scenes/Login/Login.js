import React from 'react';
import PropTypes from 'prop-types';
import { not } from 'ramda';
//
import LoginForm from './components/LoginForm';
import withStyle from './hoc/withStyle';

const Login = ({
  className,
  loggedUser,
  errorMsg,
  isUserValid,
  isPending,
  history
}) => {
  return (
    <div className={className}>
      <div className="Login__formContainer">
        <header>
          <h3>Login</h3>
          {not(isUserValid) && <span>{errorMsg}</span>}
        </header>
        <LoginForm
          errorMsg={errorMsg}
          isPending={isPending}
          loggedUser={loggedUser}
          history={history}
        />
      </div>
    </div>
  );
};

Login.propTypes = {
  history: PropTypes.object.isRequired,
  className: PropTypes.string.isRequired,
  loggedUser: PropTypes.func.isRequired,
  errorMsg: PropTypes.node.isRequired,
  isUserValid: PropTypes.bool.isRequired,
  isPending: PropTypes.bool.isRequired
};

export default withStyle(Login);
