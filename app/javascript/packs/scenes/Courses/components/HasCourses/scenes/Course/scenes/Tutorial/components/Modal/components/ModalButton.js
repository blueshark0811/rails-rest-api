import React from 'react';
import PropTypes from 'prop-types';
import Interactive from 'react-interactive';

const ModalButton = ({ className, style, children, handleClick }) => (
  /* this wrapper component makes our element to be interactive - adding some hover/focus/active state*/
  <Interactive
    as="button"
    hover={{ color: '#338FFC' }}
    focus={{ outline: 0 }}
    onClick={handleClick}
    style={{
      color: '#000000',
      background: 'none',
      border: 0,
      transition: 'color 300ms ease-in',
      ...style
    }}
    className={className}
  >
    {children}
  </Interactive>
);

ModalButton.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.element),
    PropTypes.element
  ]).isRequired,
  style: PropTypes.object,
  handleClick: PropTypes.func.isRequired,
  className: PropTypes.string
};

export default ModalButton;
