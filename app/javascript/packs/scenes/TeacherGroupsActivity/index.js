import React from 'react';

import SearchbarTableGroups from './components/SearchbarTableGroups';
import TableTeacherGroupsActivity from './components/TableTeacherGroupsActivity';

const TeacherGroupsActivity = () => (
  <div className="TeacherGroupsActivity">
    <SearchbarTableGroups />
    <TableTeacherGroupsActivity />
  </div>
);

export default TeacherGroupsActivity;
