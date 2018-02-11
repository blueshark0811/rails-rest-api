import React from 'react';
// base
import Tables, { TableRow, Th } from 'base_components/Tables';
// sub components
import RowsTableAdminGroupUsers from './components/RowsTableAdminGroupUsers';

// compose a table header
const TableHeaderGroupUser = ({ children }) => <Th center>{children}</Th>;

// composing the TableAdmin
const TableAdminGroupUsers = () => (
  <Tables>
    <thead>
      <TableRow>
        <TableHeaderGroupUser />
        <TableHeaderGroupUser>Profile</TableHeaderGroupUser>
        <TableHeaderGroupUser>Last Name</TableHeaderGroupUser>
        <TableHeaderGroupUser>First Name</TableHeaderGroupUser>
        <TableHeaderGroupUser>Date Added</TableHeaderGroupUser>
        <TableHeaderGroupUser>Status</TableHeaderGroupUser>
        <TableHeaderGroupUser>Role</TableHeaderGroupUser>
        <TableHeaderGroupUser />
      </TableRow>
    </thead>
    <RowsTableAdminGroupUsers />
  </Tables>
);

export default TableAdminGroupUsers;
