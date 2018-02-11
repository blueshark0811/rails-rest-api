import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import iconInfo from './info.svg';

const InformationText = styled(({ className, text, to }) => (
  <Link className={className} to={to}>
    <img alt="Icon group info" src={iconInfo} />
    {text}
  </Link>
))`
  color: #0e90e0;

  img {
    margin-right: 0.5em;
  }
`;

InformationText.propTypes = {
  text: PropTypes.string.isRequired,
  to: PropTypes.string.isRequired
};

export default InformationText;
