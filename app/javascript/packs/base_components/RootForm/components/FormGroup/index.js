import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const FormGroup = styled(({ className, children }) => (
  <div className={className}>{children}</div>
))`
  margin-bottom: 1.3em;

  display: ${props => props.isFlex && 'flex'};

  &:last-child {
    margin-bottom: 0;
  }
`;

FormGroup.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.element,
    PropTypes.arrayOf(PropTypes.element)
  ]).isRequired
};

export default FormGroup;
