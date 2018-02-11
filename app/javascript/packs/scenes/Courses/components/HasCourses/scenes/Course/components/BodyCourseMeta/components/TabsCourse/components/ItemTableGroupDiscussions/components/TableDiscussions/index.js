import React from 'react';
import PropTypes from 'prop-types';

import TableData from './components/TableData';
import TableDataPosted from './components/TableDataPosted';
import TableDataActivity from './components/TableDataActivity';
import Tables, { TableRow } from 'base_components/Tables';

const TableDiscussions = ({ discussions }) => {
  const discussionRows = discussions.map(item => (
    <TableRow key={item.id}>
      <TableDataPosted discussion={item} />
      <TableData>{item.dateAdded}</TableData>
      <TableData>{item.comments.length}</TableData>
      <TableDataActivity activity={item.activities[0]} />
    </TableRow>
  ));

  return (
    <Tables>
      <thead>
        <TableRow>
          <th />
          <th>Date Added</th>
          <th>Comment</th>
          <th>Latest Activity</th>
        </TableRow>
      </thead>
      <tbody>{discussionRows}</tbody>
    </Tables>
  );
};

TableDiscussions.propTypes = {
  discussions: PropTypes.array.isRequired
};

export default TableDiscussions;
