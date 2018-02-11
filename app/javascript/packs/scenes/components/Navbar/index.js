import React from 'react';
import PropTypes from 'prop-types';

import ButtonTriggerSidebar from './components/ButtonTriggerSidebar';
import Notification from './components/Notification';
import './styles.css';

const Navbar = ({ onOpenSidebar }) => {
  return (
    <nav className="Navbar">
      <ButtonTriggerSidebar onOpenSidebar={onOpenSidebar} />
      <Notification />
    </nav>
  );
};

Navbar.propTypes = {
  onOpenSidebar: PropTypes.func.isRequired
};

export default Navbar;
