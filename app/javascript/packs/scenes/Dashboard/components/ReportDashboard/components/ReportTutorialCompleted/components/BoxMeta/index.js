import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const BoxMeta = styled(({ className, spanFirst, spanLast }) => (
  <div className={className}>
    <span>{spanFirst}</span>
    <span>{spanLast}</span>
  </div>
))`
  text-align: center;
  span {
    color: #1b93ec;
    font-size: 14px;

    &:first-child {
      display: block;
    }
  }

  margin-bottom: 1em;

  &:last-child {
    margin-bottom: 0;
    margin-top: 1em;
  }

  @media screen and (min-width: 768px) {
    margin: 0;

    &:last-child {
      margin: 0;
    }
  }
`;

BoxMeta.propTypes = {
  spanFirst: PropTypes.string.isRequired,
  spanLast: PropTypes.string.isRequired
};

export default BoxMeta;
