import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
// base components
import StatusCircle from 'base_components/StatusCircle';

const StatusUser = styled(({ className, isActive }) => (
  <div className={className}>
    <StatusCircle state={isActive ? 'active' : 'inActive'} />
    <span>Active</span>
  </div>
))`
  display: flex;
  align-items: center;

  span {
    margin-left: 0.3em;
    text-transform: uppercase;
  }
`;

StatusUser.propTypes = {
  isActive: PropTypes.bool.isRequired
};

export default StatusUser;
