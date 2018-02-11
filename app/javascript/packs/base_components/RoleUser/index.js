import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const RoleUser = styled(({ className, roleUser }) => (
  <div className={className}>
    <span>{roleUser}</span>
  </div>
))`
  display: inline-block;
  background-color: #757575;
  border-radius: 2px;
  padding: 0.2em 0.4em;

  span {
    color: #ffffff;
    text-transform: uppercase;
    font-size: 12px;
  }
`;

RoleUser.propTypes = {
  roleUser: PropTypes.string.isRequired
};

export default RoleUser;
