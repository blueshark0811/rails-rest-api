import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import withCollapsiblePanel from 'hoc/withCollapsiblePanel';

import ContentNavbarAdmin from './components/ContentNavbarAdmin';
import ListLinkAdminHorizontal from './components/ListLinkAdminHorizontal';

// Styled navbar component.
const Navbar = styled.nav`
  display: flex;
  flex-direction: column;
  background-color: #2a2d2f;
  padding: 2% 0;
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1;

  @media screen and (min-width: 768px) {
    padding: 14px 35px;
  }
`;

const NavbarAdmin = ({ onToggle, isOpenPanel }) => (
  <Navbar>
    <ContentNavbarAdmin onToggle={onToggle} />
    <ListLinkAdminHorizontal onToggle={onToggle} isOpenPanel={isOpenPanel} />
  </Navbar>
);

NavbarAdmin.propTypes = {
  onToggle: PropTypes.func.isRequired,
  isOpenPanel: PropTypes.bool.isRequired
};

export default withCollapsiblePanel(NavbarAdmin);
