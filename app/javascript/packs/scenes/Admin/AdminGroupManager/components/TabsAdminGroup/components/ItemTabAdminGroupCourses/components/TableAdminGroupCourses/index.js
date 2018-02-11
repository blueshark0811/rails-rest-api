import React from 'react';
// base components
import Tables, { TableRow, Th } from 'base_components/Tables';
// sub components
import RowsTableAdminGroupCourses from './components/RowsTableAdminGroupCourses';

// compose a table header
const TableHeaderGroupUser = ({ children }) => <Th center>{children}</Th>;

const TableAdminGroupCourses = () => (
  <Tables>
    <thead>
      <TableRow>
        <Th />
        <TableHeaderGroupUser>Course Name</TableHeaderGroupUser>
        <TableHeaderGroupUser>Date Added</TableHeaderGroupUser>
        <TableHeaderGroupUser>Status</TableHeaderGroupUser>
        <TableHeaderGroupUser />
      </TableRow>
    </thead>
    <RowsTableAdminGroupCourses />
  </Tables>
);

export default TableAdminGroupCourses;
