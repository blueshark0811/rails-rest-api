import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

import LinkNavbarAdmin from '../LinkNavbarAdmin';

const ListLinkHorizontal = styled.ul`
  margin-top: 0.8em;
  display: ${props => (props.isOpenPanel ? 'block' : 'none')};

  @media screen and (min-width: 768px) {
    display: none;
  }
`;

const ListLinkAdminHorizontal = ({ isOpenPanel, onToggle }) => (
  <ListLinkHorizontal isOpenPanel={isOpenPanel}>
    <li onClick={onToggle}>
      <LinkNavbarAdmin activeClassName="active" to="/admin/group-manager">
        Group Manager
      </LinkNavbarAdmin>
    </li>
    <li onClick={onToggle}>
      <LinkNavbarAdmin activeClassName="active" to="/admin/course-creator">
        Course Creator
      </LinkNavbarAdmin>
    </li>
    <li onClick={onToggle}>
      <LinkNavbarAdmin activeClassName="active" to="/admin/user-manager">
        User Manager
      </LinkNavbarAdmin>
    </li>
    <li onClick={onToggle}>
      <LinkNavbarAdmin
        activeClassName="active"
        to="/admin/organisation-settings"
      >
        Organisation Settings
      </LinkNavbarAdmin>
    </li>
  </ListLinkHorizontal>
);

ListLinkAdminHorizontal.propTypes = {
  isOpenPanel: PropTypes.bool.isRequired,
  onToggle: PropTypes.func.isRequired
};

export default ListLinkAdminHorizontal;
