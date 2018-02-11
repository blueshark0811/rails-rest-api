import React from 'react';
import PropTypes from 'prop-types';

import './styles.css';

const Menu = ({ children }) => {
  return <ul className="Menu">{children}</ul>;
};

Menu.propTypes = {
  children: PropTypes.arrayOf(PropTypes.element).isRequired
};

export default Menu;
