import React from 'react';
import PropTypes from 'prop-types';

const ListRowRight = ({ children, className }) => {
  return <div className={`List__row__right ${className}`}>{children}</div>;
};

ListRowRight.defaultProps = {
  className: ''
};

ListRowRight.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.element),
    PropTypes.element
  ]),
  className: PropTypes.string
};

export default ListRowRight;
