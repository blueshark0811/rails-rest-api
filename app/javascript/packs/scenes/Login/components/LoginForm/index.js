import React from 'react';
import PropTypes from 'prop-types';
//
import Button from 'base_components/RootButton';
import withState from './hoc/withState';
import { identical, compose, not } from 'ramda';

const LoginForm = ({
  onHandleChange,
  clearForm,
  username,
  password,
  loggedUser,
  isPending,
  history
}) => {
  // event handler for form onSubmit event.
  const onSubmit = e => {
    e.preventDefault();
    // chaining on the promise data
    loggedUser({ username, password }).then(res => {
      // if successfull, we will redirect to other page.
      if (identical(res.status, 'successfully')) {
        // redirec based on the user type.
        // if type is student or teacher
        if (compose(not, identical(res.user.type))('Admin')) {
          return history.push('/');
        }
        // else admin, redirect to /admin/group-manager
        return history.push('/admin/group-manager');
        /* redirectBasedOnType(res.user.type);*/
      }

      // not successfull. clear the form
      clearForm();
    });
  };

  return (
    <form onSubmit={onSubmit}>
      <input
        autoFocus={true}
        onChange={onHandleChange}
        name="username"
        type="text"
        value={username}
        placeholder="Username"
      />
      <input
        onChange={onHandleChange}
        name="password"
        type="password"
        value={password}
        placeholder="Password"
      />
      <Button disabled={isPending}>Login</Button>
    </form>
  );
};

LoginForm.propTypes = {
  onHandleChange: PropTypes.func.isRequired,
  clearForm: PropTypes.func.isRequired,
  username: PropTypes.string,
  password: PropTypes.string,
  loggedUser: PropTypes.func.isRequired,
  isPending: PropTypes.bool.isRequired,
  history: PropTypes.object.isRequired
};

export default withState(LoginForm);
