import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';

import './style.css';

const PopoverRow = ({ text, url }) => {
  return (
    <li className="PopoverRow">
      <Link to={url}>{text}</Link>
    </li>
  );
};

PopoverRow.propTypes = {
  text: PropTypes.string.isRequired
};

export default PopoverRow;
