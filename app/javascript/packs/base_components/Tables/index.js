import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { Table } from 'react-bootstrap';

import TableRow from './components/TableRow';
import Td from './components/Td';
import Th from './components/Th';

// TODO -> turn the sub components into styled component.
const Tables = styled(({ children, className }) => (
  <Table className={`Tables ${className}`} responsive>
    {children}
  </Table>
))`
  & .Tables__row {
    border-bottom: 1px solid #dadada;
    transition: background 300ms ease-in;
    &:hover {
      background: #f2f3f6;
    }
  }
  & .Tables__row th,
  & .Tables__row td {
    border: 0;
  }
  & .Tables__row td:last-child {
    text-align: right;
  }
  & .Tables__row th {
    font-size: 12px;
    font-weight: 400;
    color: #636363;
    text-transform: uppercase;
    padding-bottom: 3px;
  }
  & .Tables__row td {
    vertical-align: middle;
    color: #111111;
  }
`;

Tables.propTypes = {
  children: PropTypes.arrayOf(PropTypes.element).isRequired,
  className: PropTypes.string
};

export { Tables as default, TableRow, Th, Td };
