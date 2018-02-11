import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';

import './styles.css';

const RowLink = ({ text, url }) => {
  return (
    <Link className="RowLink" to={url}>
      {text}
    </Link>
  );
};

RowLink.propTypes = {
  text: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired
};

export default RowLink;
