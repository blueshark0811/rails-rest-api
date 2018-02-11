import React from 'react';
import PropTypes from 'prop-types';
import { NavLink as LinkRoute } from 'react-router-dom';

const Link = ({ text, url, isStrict, className }) => {
  // check if the link is strict not exact - get active even though that the url has a trailing slash
  if (isStrict) {
    return (
      <LinkRoute strict activeStyle={{ color: '#0E90E0' }} to={url}>
        {text}
      </LinkRoute>
    );
  }
  // else
  return (
    <LinkRoute exact activeStyle={{ color: '#0E90E0' }} to={url}>
      {text}
    </LinkRoute>
  );
};

Link.propTypes = {
  text: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired,
  isStrict: PropTypes.bool,
  className: PropTypes.string
};

export default Link;
