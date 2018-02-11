import React from 'react';
import PropTypes from 'prop-types';

const ListRowLeft = ({ children, className }) => {
  return <div className={`List__row__left ${className}`}>{children}</div>;
};

ListRowLeft.defaultProps = {
  className: ''
};

ListRowLeft.propTypes = {
  children: PropTypes.arrayOf(PropTypes.element),
  className: PropTypes.string
};

export default ListRowLeft;
