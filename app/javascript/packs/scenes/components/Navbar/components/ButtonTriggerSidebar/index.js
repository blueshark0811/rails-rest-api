import React from 'react';
import PropTypes from 'prop-types';
import IconBurger from 'react-icons/lib/fa/align-justify';

import './styles.css';

const ButtonTriggerSidebar = ({ onOpenSidebar }) => {
  return (
    <button
      onClick={onOpenSidebar}
      className="ButtonTriggerSidebar"
      type="button"
    >
      <IconBurger />
    </button>
  );
};

ButtonTriggerSidebar.propTypes = {
  onOpenSidebar: PropTypes.func.isRequired
};

export default ButtonTriggerSidebar;
