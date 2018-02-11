import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';

import './styles.css';

const LinkButton = ({ secondary, style, text, url, className }) => {
  const secondaryClass = secondary ? 'LinkButton--secondary' : '';
  return (
    <Link
      style={style}
      className={`LinkButton ${className} ${secondaryClass}`}
      to={url}
    >
      {text}
    </Link>
  );
};

LinkButton.propTypes = {
  text: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired,
  style: PropTypes.object,
  className: PropTypes.string,
  secondary: PropTypes.bool
};

export default LinkButton;
